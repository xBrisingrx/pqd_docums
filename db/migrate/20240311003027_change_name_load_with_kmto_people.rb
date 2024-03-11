class ChangeNameLoadWithKmtoPeople < ActiveRecord::Migration[5.2]
  def change
    rename_column :people, :load_with_km, :load_without_km
  end
end
