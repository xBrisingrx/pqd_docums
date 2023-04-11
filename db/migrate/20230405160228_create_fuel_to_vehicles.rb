class CreateFuelToVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :fuel_to_vehicles do |t|
      t.references :vehicle, foreign_key: true
      t.references :fuel_supplier, foreign_key: true
      t.references :load, foreign_key: { to_table: 'people' }
      t.references :authorize, foreign_key: { to_table: 'people' }
      t.date :date, null: false
      t.decimal :fueling, null: false
      t.bigint :mileage, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
