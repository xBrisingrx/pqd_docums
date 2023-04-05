class CreateClothesPacks < ActiveRecord::Migration[5.2]
  def change
    create_table :clothes_packs do |t|
      t.references :clothe, foreign_key: true
      t.references :clothing_package, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
