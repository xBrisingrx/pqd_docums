module VehicleInsurancesHelper

	def show_vehicle_insurances_files vehicle_insurance 
		pdf_button = ''
		if vehicle_insurance.files.attached? 
			if vehicle_insurance.files.count == 1
				pdf_button = "#{ link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, vehicle_insurance.files.first, target: '_blank' }"
			else
				pdf_button = "#{ link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, 
							show_files_vehicle_insurances_path( id: vehicle_insurance.id), remote: true }"
			end
		else
			pdf_button = "<p><i class='fa fa-file-pdf-o fa-2x'></i></p>"
		end
		
		pdf_button
	end
end
