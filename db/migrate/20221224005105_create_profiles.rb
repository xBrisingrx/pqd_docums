class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :d_type
      t.string :name, null:false
      t.date :start_date, comment: "Desde cuando se empezo a usar este perfil"
      t.date :end_date, comment: "Hasta cuando se uso perfil"
      t.string :description
      t.boolean :active, null:false, default:true

      t.timestamps
    end
  end
end
