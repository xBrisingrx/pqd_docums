class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :code, null: false
      t.string :domain
      t.string :chassis
      t.string :engine
      t.integer :year, default: 0
      t.text :observations
      t.boolean :active, default: true
      t.boolean :is_company, default: true
      t.references :vehicle_type, foreign_key: true
      t.references :vehicle_model, foreign_key: true
      t.references :vehicle_location, foreign_key: true

      t.timestamps
    end
  end
end
