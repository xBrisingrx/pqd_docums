class ChangeKilometersForServicesToVehicles < ActiveRecord::Migration[5.2]
  def change
    rename_column :vehicles, :kilometers_for_service, :mileage_for_service
  end
end
