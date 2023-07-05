class CreateMigrateFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :migrate_files do |t|
      t.string :table
      t.bigint :table_id
      t.string :column
      t.string :path

      t.timestamps
    end
  end
end
