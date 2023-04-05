class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.integer :d_type, null:false
      t.string :name, null:false
      t.string :description
      t.boolean :expires, default: false
      t.integer :days_of_validity, default: 0
      t.boolean :allow_modify_expiration, default: false
      t.text :observations
      t.text :renewal_methodology
      t.boolean :monthly_summary, default: true
      t.date :start_date, comment: "Desde cuando se empezo a usar este documento"
      t.date :end_date, comment: "Hasta cuando se uso este documento"
      t.boolean :active, default: true

      t.references :document_category, foreign_key: true
      t.references :expiration_type, foreign_key: true
      t.timestamps
    end
  end
end
