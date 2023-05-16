class ChangeDateNamesToClosures < ActiveRecord::Migration[5.2]
  def change
    rename_column :closures, :from, :start_date
    rename_column :closures, :until, :end_date
  end
end
