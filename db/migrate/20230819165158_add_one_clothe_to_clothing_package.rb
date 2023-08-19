class AddOneClotheToClothingPackage < ActiveRecord::Migration[5.2]
  def change
    add_column :clothing_packages, :one_clothes, :boolean, default: false
  end
end
