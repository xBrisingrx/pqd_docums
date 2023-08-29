class ChangeFileFieldToPeople < ActiveRecord::Migration[5.2]
  def up
    change_column :people, :file, :string, null: false
  end

  def down
    change_column :people, :file, :integer, null: false
  end
end
