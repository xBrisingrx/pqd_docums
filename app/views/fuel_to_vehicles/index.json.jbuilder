json.data @fuel_to_vehicles do |fuel_vehicle|
	json.date date_format(fuel_vehicle.date)
	json.vehicle fuel_vehicle.vehicle.code
	json.mileage fuel_vehicle.mileage
	json.fueling fuel_vehicle.fueling
	json.fuel_type fuel_vehicle.fuel_type_name
	json.supplier fuel_vehicle.fuel_supplier.name 
	json.person_load fuel_vehicle.person_load.fullname
	json.person_authorize fuel_vehicle.person_authorize.fullname
	json.ticket fuel_vehicle.ticket
	json.cost_center fuel_vehicle.cost_center.name
	json.actions ""
end
