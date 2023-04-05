class CreateVehicleLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_locations do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
