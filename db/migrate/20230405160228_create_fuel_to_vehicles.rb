class CreateFuelToVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :fuel_to_vehicles do |t|
      t.references :vehicle, foreign_key: true
      t.references :fuel_supplier, foreign_key: true
      t.references :person_load, foreign_key: { to_table: 'people' }
      t.references :person_authorize, foreign_key: { to_table: 'people' }
      t.date :date, null: false
      t.decimal :fueling, null: false
      t.bigint :mileage, null: false
      t.bigint :ticket, null: false
      t.integer :fuel_type, default: 1
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
