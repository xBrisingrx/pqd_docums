class CreateVehicleBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_brands do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
