json.data @vehicle_services do |vehicle_service|
	json.date date_format(vehicle_service.date)
	currently_data = "<ul>"
	next_service = "<ul>"
	if vehicle_service.mileage?
		currently_data += "<li>#{vehicle_service.mileage} KM</li>"
		next_service += "<li>#{vehicle_service.mileage_next_service} KM</li>"
	end

	if vehicle_service.hours?
		currently_data += "<li>#{vehicle_service.hours} HS</li>"
		next_service += "<li>#{vehicle_service.hours_next_service} HS</li>"
	end
	currently_data += "</ul>"
	next_service += "</ul>"
	json.mileage currently_data
	json.mileage_next_service next_service
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe,vehicle_service_path(vehicle_service), class: 'btn u-btn-orange btn-sm', remote: true}"
end