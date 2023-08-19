# == Schema Information
#
# Table name: clothes_packs
#
#  id                  :bigint           not null, primary key
#  clothe_id           :bigint
#  clothing_package_id :bigint
#  active              :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class ClothesPack < ApplicationRecord
  belongs_to :clothe
  belongs_to :clothing_package

  validates :clothe_id, uniqueness: { scope: :clothing_package_id, message: "Esta prenda ya se encuentra agregada a este pack" }
  scope :actives, -> { where(active: true) }
end
