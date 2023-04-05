# == Schema Information
#
# Table name: vehicle_brands
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class VehicleBrand < ApplicationRecord
	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "La marca ya se encuentra registrada" }

	scope :actives, -> { where(active: true) }
	
end
