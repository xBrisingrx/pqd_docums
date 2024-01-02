class AddHoursToVehicleServices < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicle_services, :hours, :bigint
    add_column :vehicle_services, :hours_next_service, :bigint
  end
end
