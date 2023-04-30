class AddCostCenterToFuelToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_reference :fuel_to_vehicles, :cost_center, foreign_key: true
  end
end
