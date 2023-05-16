class ChangeImputedDateToTickets < ActiveRecord::Migration[5.2]
  def change
    rename_column :fuel_to_vehicles, :imputed_date, :computable_date
  end
end
