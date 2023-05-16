class ChangeFuelToVehicles < ActiveRecord::Migration[5.2]
  def change
    remove_column :fuel_to_vehicles, :ticket 
    add_reference :fuel_to_vehicles, :ticket, foreign_key: true
    add_column :fuel_to_vehicles, :imputed_date, :date
  end
end
