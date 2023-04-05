class CreatePeopleClothes < ActiveRecord::Migration[5.2]
  def change
    create_table :people_clothes do |t|
      t.references :person, foreign_key: true
      t.references :clothing_package, foreign_key: true
      t.text :description, default: ''
      t.date :start_date
      t.date :end_date
      t.boolean :active, default: true
      t.boolean :expires, default: true

      t.timestamps
    end
  end
end
