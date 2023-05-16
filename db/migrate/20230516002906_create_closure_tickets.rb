class CreateClosureTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :closure_tickets do |t|
      t.references :closure, foreign_key: true
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
