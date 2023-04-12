class ReportsController < ApplicationController

	def index;end

	def people
		@people = Person.actives.order(last_name: :ASC)
		respond_to do |format|
			format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="listado_personal.xlsx"'
      }
		end
	end

	def matriz
		@column_titles = ['LEGAJO', 'APELLIDO/S, NOMBRE/S (DNI)']
		@index_name = ['file', 'fullname']
		@documents = Document.where(d_type: 1).actives.pluck(:id, :name)
		@title = 'Excel title'
		@documents.map { |document|
			@index_name << "document_#{document[0]}"
			@column_titles << document[1]
		}

		respond_to do |format|
			format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="informe_matriz_personas.xlsx"'
      }
		end
	end

	def fuel 
		start_date = Date.today.at_beginning_of_month
		end_date = start_date + 45.day
		@month = I18n.t("date.month_names")[Date.today.month]
		@year = Date.today.year
		@abbr_year = (Time.now).strftime("%y")
		@abbr_month = "#{I18n.t("date.abbr_month_names")[Date.today.month]}-#{@abbr_year}"
		@page_name = "#{@month.capitalize}-#{Date.today.year}"

		@fuel_to_vehicles = FuelToVehicle.where(date: start_date..end_date).actives.order(:date)
	end
end
