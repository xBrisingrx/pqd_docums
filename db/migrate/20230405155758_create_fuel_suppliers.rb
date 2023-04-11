class CreateFuelSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :fuel_suppliers do |t|
      t.string :name, null: false
      t.string :description
      t.integer :supplier_type, null: false
      t.boolean :fuel_unlimited, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
