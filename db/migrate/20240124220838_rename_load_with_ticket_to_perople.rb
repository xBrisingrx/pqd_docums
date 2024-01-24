class RenameLoadWithTicketToPerople < ActiveRecord::Migration[5.2]
  def change
    rename_column :people, :load_with_ticket, :load_without_ticket
  end
end
