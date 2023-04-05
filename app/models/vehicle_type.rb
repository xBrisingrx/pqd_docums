# == Schema Information
#
# Table name: vehicle_types
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class VehicleType < ApplicationRecord
	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "Este tipo de vehiculo ya se encuentra registrado" }

	scope :actives, -> { where(active: true) }
	
end
