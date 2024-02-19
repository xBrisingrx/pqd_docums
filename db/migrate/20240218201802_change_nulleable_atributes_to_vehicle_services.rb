class ChangeNulleableAtributesToVehicleServices < ActiveRecord::Migration[5.2]
  def change
    change_column :vehicle_services, :mileage, :integer, null: true
    change_column :vehicle_services, :mileage_next_service, :integer, null: true
    change_column :vehicle_services, :hours, :integer, null: true
    change_column :vehicle_services, :hours_next_service, :integer, null: true
  end
end