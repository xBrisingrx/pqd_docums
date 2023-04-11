class CreateFuelLoads < ActiveRecord::Migration[5.2]
  def change
    create_table :fuel_loads do |t|
      t.references :fuel_supplier, foreign_key: true
      t.decimal :fueling, null: false
      t.date :date, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
