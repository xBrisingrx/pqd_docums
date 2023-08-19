class ReportsController < ApplicationController

	def index
		@documents = Document.where( d_type: 1 ).actives.order( :name )
	end

	def people
		@people = Person.actives.order(last_name: :ASC)
		respond_to do |format|
			format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="listado_personal.xlsx"'
      }
		end
	end

	def people_documents
		people_report_data
		respond_to do |format|
			format.xlsx {
		    render xlsx: "reports/report_expiration_documents", disposition: "attachment", filename: "vencimientos_personal.xlsx"
		  }
		end
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

	def get_letter number
		h = {}
		('A'..'ZZZ').each_with_index{|w, i| h[i+1] = w }
		h[number]
	end

	def people_report_data
		@column_titles = ['LEGAJO', 'APELLIDO/S, NOMBRE/S (DNI)']
		@index_name = {'file' => '', 'fullname' => ''}
		@data = Array.new

		if params[:document_ids].blank?
			@documents = Document.where(d_type: :people).actives.order(:name).pluck(:id, :name)
		else
			@documents = Document.where(id: params[:document_ids]).order(:name).pluck(:id, :name)
		end
		
		@title = 'Vencimientos documentos personas'
		if !params[:start_date].blank?
			start_date = Date.parse(params[:start_date])
			@title += " desde #{ start_date.strftime('%d-%m-%y') }"
		end
		
		if !params[:end_date].blank?
			end_date = Date.parse(params[:end_date])
			@title += " hasta #{ end_date.strftime('%d-%m-%y') }"
		end

		@documents.map { |document|
			@index_name["#{document[0]}"] = ''
			@column_titles << document[1]
		} 
		@letter_title = get_letter( @index_name.count ) # aca aca se pinga el row del titulo
		row = @index_name.clone
		people = Person.actives.order(:file).select(:id, :file,:name, :last_name,:dni)
		people.each do |person|
			if params[:document_ids].blank?
				documents = AssignmentsDocument.where( assignated: person ).actives
			else
				documents = AssignmentsDocument.where( assignated: person ).where( document_id: params[:document_ids] ).actives
			end
			documents.map { |document| 
				renovation = document.last_renovation
				if renovation.blank?
					row["#{document.document.id}"] = 'No cargado'
				else
					row["#{document.document.id}"] = ( document.document.expires? ) ? renovation.expiration_date.strftime('%d-%m-%y') : 'Cargado'
				end
			}

			row['file'] = person.file
			row['fullname'] = "#{person.fullname} #{person.dni}"

			@data.push(row) 
			row = @index_name.clone
		end # end people each
	end # end people_report_data

end
