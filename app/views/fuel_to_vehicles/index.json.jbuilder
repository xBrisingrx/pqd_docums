json.data @fuel_to_vehicles do |fuel_vehicle|
	json.vehicle fuel_vehicle.vehicle.code
	json.fueling fuel_vehicle.fueling
	json.mileage fuel_vehicle.mileage
	json.date date_format(fuel_vehicle.date)
	json.actions ""
end
