class CreateExpirationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :expiration_types do |t|
      t.string :name
      t.integer :days
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
