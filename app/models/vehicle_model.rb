# == Schema Information
#
# Table name: vehicle_models
#
#  id               :bigint           not null, primary key
#  name             :string(255)      not null
#  description      :string(255)
#  active           :boolean          default(TRUE)
#  vehicle_brand_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class VehicleModel < ApplicationRecord
  belongs_to :vehicle_brand

  validates :name, presence: true, 
    uniqueness: { scope: :vehicle_brand_id ,case_sensitive: false, message: "Esta marca ya se encuentra registrada" }

  scope :actives, -> { where(active: true) }
  
end
