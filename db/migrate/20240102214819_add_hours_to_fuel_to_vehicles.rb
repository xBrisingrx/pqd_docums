class AddHoursToFuelToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_column :fuel_to_vehicles, :hours, :bigint
  end
end
