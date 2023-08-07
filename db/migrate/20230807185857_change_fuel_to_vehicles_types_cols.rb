class ChangeFuelToVehiclesTypesCols < ActiveRecord::Migration[5.2]
  def change
    change_column :fuel_to_vehicles, :fueling, :decimal, precision: 15, scale: 2
    change_column :fuel_to_vehicles, :mileage, :decimal, precision: 15, scale: 2
  end
end
