class CreateReasonsToDisables < ActiveRecord::Migration[5.2]
  def change
    create_table :reasons_to_disables do |t|
      t.integer :d_type, null: false
      t.string :reason, null: false
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
