class AddExpirationTypeToClothingPackages < ActiveRecord::Migration[5.2]
  def change
    add_reference :clothing_packages, :expiration_type, foreign_key: true
  end
end
