class CreateClothingPackages < ActiveRecord::Migration[5.2]
  def change
    create_table :clothing_packages do |t|
      t.string :name, null: false
      t.text :description
      t.integer :days_of_validity, null: false, default: 0
      t.boolean :expires, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
