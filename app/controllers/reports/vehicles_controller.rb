class Reports::VehiclesController < ApplicationController

	def index
		@documents = Document.where( d_type: 2 ).actives.order( :name )
	end

	def document_expirations_between_dates
		@column_titles = ['Interno']
		@index_name = {'code'=> '' }
		@data = Array.new

		if params[:document_ids].blank?
			@documents = Document.where(d_type: :vehicles).actives.order(:name).pluck(:id, :name)
		else
			@documents = Document.where(id: params[:document_ids]).order(:name).pluck(:id, :name)
		end
		
		@insurances = Insurance.actives.order(:name).pluck(:id, :name)

		@title = 'Vencimientos documentos vehiculos '
		if !params[:start_date].blank?
			start_date = Date.parse(params[:start_date])
			@title += "desde #{ start_date.strftime('%d-%m-%y') }"
		end
		
		if !params[:end_date].blank?
			end_date = Date.parse(params[:end_date])
			@title += " hasta #{ end_date.strftime('%d-%m-%y') }"
		end

		@documents.map { |document|
			@index_name["#{document[0]}"] = ''
			@column_titles << document[1]
		} 

		@insurances.map { |document|
			@index_name["insurance_#{document[0]}"] = ''
			@column_titles << document[1]
		} 
		row = @index_name.clone
		vehicles = Vehicle.actives.order(:code)

		vehicles.each do |vehicle|
			if params[:document_ids].blank?
				documents = AssignmentsDocument.where( assignated: vehicle ).actives
			else
				documents = AssignmentsDocument.where( assignated: vehicle ).where( document_id: params[:document_ids] ).actives
			end
			
			documents.map { |document| 
				renovation_date = document.last_renovation_between_dates( params[:start_date], params[:end_date] )
				if renovation_date.blank?
					row["#{document.document.id}"] = 'No cargado'
				elsif renovation_date === '---'
					# esta el documento cargado pero no hay vencimiento en estas fechas
					row["#{document.document.id}"] = ''
				else
					row["#{document.document.id}"] = ( document.document.expires? ) ? renovation_date : 'Cargado'
				end
			}

			vehicle.vehicle_insurances.actives.order( :end_date ).map { |vehicle_insurance| 
				row["insurance_#{vehicle_insurance.insurance.id}"] =vehicle_insurance.end_date.strftime('%d-%m-%y')
			}

			row['code'] = vehicle.code

			@data.push(row) 
			row = @index_name.clone

		end

		render xlsx: "document_expirations", disposition: "attachment", filename: "vencimientos_vehiculos.xlsx"
	end

	def document_expirations
		@column_titles = ['Interno']
		@index_name = {'code'=> '' }
		@data = Array.new
		@documents = Document.where(d_type: :vehicles).actives.order(:name).pluck(:id, :name)
		@insurances = Insurance.actives.pluck(:id, :name)
		@title = 'Vencimientos vehiculos'
		@documents.map { |document|
			@index_name["#{document[0]}"] = ''
			@column_titles << document[1]
		} 

		@insurances.map { |document|
			@index_name["insurance_#{document[0]}"] = ''
			@column_titles << document[1]
		} 

		row = @index_name.clone
		vehicles = Vehicle.actives.order(:code)
		vehicles.each do |vehicle|
			documents = AssignmentsDocument.where( assignated: vehicle ).actives 
			documents.map { |document| 
				renovation = document.last_renovation
				if renovation.blank?
					row["#{document.document.id}"] = 'No cargado'
				else
					row["#{document.document.id}"] = ( document.document.expires? ) ? renovation.expiration_date.strftime('%d-%m-%y') : 'Cargado'
				end
			}

			vehicle.vehicle_insurances.actives.order( :end_date ).map { |vehicle_insurance| 
				row["insurance_#{vehicle_insurance.insurance.id}"] =vehicle_insurance.end_date.strftime('%d-%m-%y')
			}

			row['code'] = vehicle.code

			@data.push(row) 
			row = @index_name.clone

		end

		# send_file(doc.path, :disposition => 'attachment', :filename => "bitacora.xlsx", type: "application/xml")

		render xlsx: "document_expirations", disposition: "attachment", filename: "vencimientos_vehiculos.xlsx"
	end

	def modal_fuel_report;end

	def fuel
		start_date = (params[:start_date]) ? params[:start_date] : Date.today.at_beginning_of_month
		end_date = (params[:end_date]) ? params[:end_date] : start_date + 45.day
		@month = I18n.t("date.month_names")[Date.today.month]
		@year = Date.today.year
		@abbr_year = (Time.now).strftime("%y")
		@abbr_month = "#{I18n.t("date.abbr_month_names")[Date.today.month]}-#{@abbr_year}"
		@page_name = "#{@month.capitalize}-#{Date.today.year}"

		@fuel_to_vehicles = FuelToVehicle.where(computable_date: start_date..end_date).actives.order(:date)
		@total_lts = @fuel_to_vehicles.sum(:fueling).to_s
		render xlsx: 'Resumen mensual', template: 'reports/fuel'
	end

	def by_closure
		closure = Closure.find(params[:closure_id])
		tickets = closure.tickets.pluck(:id)
		@fuel_to_vehicles = FuelToVehicle.where("ticket_id IN (?)", tickets).actives.order(:date)
		@total_lts = @fuel_to_vehicles.sum(:fueling).to_s
		@page_name = "Cierre #{I18n.t("date.abbr_month_names")[closure.start_date.month]}"
		render xlsx: 'Cierre', template: 'reports/fuel'
	end


end