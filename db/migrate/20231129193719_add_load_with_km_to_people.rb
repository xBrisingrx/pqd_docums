class AddLoadWithKmToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :load_with_km, :boolean, default:true
  end
end
