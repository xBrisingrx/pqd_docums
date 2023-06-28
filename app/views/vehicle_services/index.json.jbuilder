json.data @vehicle_services do |vehicle_service|
	json.date date_format(vehicle_service.date)
	json.mileage vehicle_service.mileage
	json.mileage_next_service vehicle_service.mileage_next_service
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe,vehicle_service_path(vehicle_service), class: 'btn u-btn-orange btn-sm', remote: true}"
end