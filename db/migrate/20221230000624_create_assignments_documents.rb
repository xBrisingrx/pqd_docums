class CreateAssignmentsDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments_documents do |t|
      t.references :assignated, polymorphic: true
      t.references :document, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :custom, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
