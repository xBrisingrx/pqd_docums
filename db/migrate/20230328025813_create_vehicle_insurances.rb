class CreateVehicleInsurances < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_insurances do |t|
      t.references :vehicle, foreign_key: true
      t.references :insurance, foreign_key: true
      t.string :policy, null: false
      t.date :start_date
      t.date :end_date
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end

      