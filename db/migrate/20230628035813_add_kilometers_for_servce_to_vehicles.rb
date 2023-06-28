class AddKilometersForServceToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :kilometers_for_service, :bigint
  end
end
