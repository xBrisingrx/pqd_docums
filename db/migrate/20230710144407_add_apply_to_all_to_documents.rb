class AddApplyToAllToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :apply_to_all, :boolean, default: false
  end
end
