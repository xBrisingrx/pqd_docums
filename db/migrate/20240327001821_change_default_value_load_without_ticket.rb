class ChangeDefaultValueLoadWithoutTicket < ActiveRecord::Migration[5.2]
  def change
    change_column :people, :load_without_km, :boolean, default: false
  end
end
