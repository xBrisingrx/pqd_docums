class CreateDocumentCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :document_categories do |t|
      t.string :name
      t.string :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
