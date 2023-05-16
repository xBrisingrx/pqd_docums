class CreateClosures < ActiveRecord::Migration[5.2]
  def change
    create_table :closures do |t|
      t.string :name, null: false
      t.date :from, null: false
      t.date :until, null: false

      t.timestamps
    end
  end
end
