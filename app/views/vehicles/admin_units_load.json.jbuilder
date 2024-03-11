json.data @vehicles do |vehicle|
	json.code vehicle.code
  json.unit_load " #{ render partial: 'vehicles/option_select_unit_load', locals: { vehicle:vehicle, units_load: @units_load } } "
  json.mileage_for_service text_field( :vehicle, :unit_load, class: 'form-control update-unit', value: vehicle.mileage_for_service, 
    data: { id: vehicle.id, unit: 'mileage' }, onchange: 'update_unit_value( event )' )
  json.hours_for_service text_field( :vehicle, :unit_load, class: 'form-control update-unit', value: vehicle.hours_for_service, 
    data: { id: vehicle.id, unit: 'hours' }, onchange: 'update_unit_value( event )' )
end


