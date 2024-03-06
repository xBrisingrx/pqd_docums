class ChangeLoadWithTicketToPerople < ActiveRecord::Migration[5.2]
  def change
    change_column :people, :load_without_ticket, :boolean, default:false
  end
end
