json.extract! vehicle_service, :id, :date, :vehicle_id, :mileage, :mileage_next_service, :comment, :created_at, :updated_at
json.url vehicle_service_url(vehicle_service, format: :json)
