class AddCompletedToTicketBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :ticket_books, :completed, :boolean, default: false
  end
end
