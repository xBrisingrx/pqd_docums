class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :number, null: false
      t.boolean :used, default: 0
      t.boolean :active, default: true
      t.references :ticket_book, foreign_key: true
      t.timestamps
    end
  end
end
