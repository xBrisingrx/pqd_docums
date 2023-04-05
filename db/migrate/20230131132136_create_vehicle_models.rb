class CreateVehicleModels < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_models do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :active, default: true
      t.references :vehicle_brand, foreign_key: true

      t.timestamps
    end
  end
end
