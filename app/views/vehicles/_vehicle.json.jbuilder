json.set! :id, vehicle.id
json.set! :code, vehicle.code
json.set! :domain, vehicle.domain
json.set! :model, vehicle.vehicle_model.name
json.set! :brand, vehicle.brand
json.set! :year, vehicle.year
json.set! :type, vehicle.vehicle_type.name
json.set! :need_service, vehicle.status_mileage_for_service


