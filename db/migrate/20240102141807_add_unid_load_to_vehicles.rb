class AddUnidLoadToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :unit_load, :integer, null:false, default: 1
  end
end
