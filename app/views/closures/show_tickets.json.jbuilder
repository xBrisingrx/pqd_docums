json.data @tickets do |ticket|
	json.date date_format(ticket.fuel_to_vehicle.date)
	json.vehicle ticket.fuel_to_vehicle.vehicle.code
	json.mileage ticket.fuel_to_vehicle.mileage
	json.fueling ticket.fuel_to_vehicle.fueling
	json.fuel_type ticket.fuel_to_vehicle.fuel_type_name
	json.supplier ticket.fuel_to_vehicle.fuel_supplier.name 
	json.person_load ticket.fuel_to_vehicle.person_load.fullname
	json.person_authorize ticket.fuel_to_vehicle.person_authorize.fullname
	json.ticket ticket.number
	json.cost_center ticket.fuel_to_vehicle.cost_center.name
end
