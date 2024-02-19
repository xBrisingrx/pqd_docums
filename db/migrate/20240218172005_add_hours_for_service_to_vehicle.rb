class AddHoursForServiceToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :hours_for_service, :integer
  end
end
