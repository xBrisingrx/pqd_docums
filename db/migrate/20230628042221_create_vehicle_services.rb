class CreateVehicleServices < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_services do |t|
      t.date :date, null: false
      t.references :vehicle, foreign_key: true
      t.bigint :mileage, null:false
      t.bigint :mileage_next_service, null:false
      t.text :comment
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
