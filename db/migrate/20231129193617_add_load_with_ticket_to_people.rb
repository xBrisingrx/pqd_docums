class AddLoadWithTicketToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :load_with_ticket, :boolean, default:true
  end
end
