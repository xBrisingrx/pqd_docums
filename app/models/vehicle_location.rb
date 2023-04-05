# == Schema Information
#
# Table name: vehicle_locations
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class VehicleLocation < ApplicationRecord
	# lugar de patentamiento del vehiculo
	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "El lugar de patentamiento ya se encuentra registrado" }

	scope :actives, -> { where(active: true) }
	
end
