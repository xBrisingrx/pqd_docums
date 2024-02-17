class ChangeMileageCanBeNull < ActiveRecord::Migration[5.2]
  def change
    change_column :fuel_to_vehicles, :mileage, :decimal, precision: 15, scale: 2, null:true
  end
end
