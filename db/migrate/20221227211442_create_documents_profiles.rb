class CreateDocumentsProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :documents_profiles do |t|
      t.integer :d_type, null: false
      t.references :profile, foreign_key: true
      t.references :document, foreign_key: true
      t.date :start_date, comment: "Desde cuando se empezo a usar este documento en este perfil"
      t.date :end_date, comment: "Hasta cuando se uso este documento en este perfil"
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
