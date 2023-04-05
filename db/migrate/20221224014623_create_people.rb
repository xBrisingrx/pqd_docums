class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.integer :file, null:false, comment: 'Legajo de la persona'
      t.string :name, null:false
      t.string :last_name, null:false
      t.string :dni
      t.bigint :tramit_number
      t.string :cuil
      t.string :email
      t.boolean :dni_has_expiration, default: true
      t.date :expiration_dni_date
      t.date :birth_date
      t.string :nationality, default: ''
      t.string :direction
      t.string :phone
      t.date :start_activity
      t.boolean :active, null:false ,default: true

      t.timestamps
    end
  end
end
