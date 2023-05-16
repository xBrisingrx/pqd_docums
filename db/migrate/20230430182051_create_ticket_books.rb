class CreateTicketBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_books do |t|
      t.string :name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
