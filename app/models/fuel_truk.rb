# == Schema Information
#
# Table name: fuel_truks
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class FuelTruk < ApplicationRecord
	has_many :fuel_loads
	scope :actives, -> { where(active: true) }

	def fuel_load
		cargas = self.fuel_loads.sum(:fueling)
		descargas = FuelToVehicle.where( fuel_truk_id: self.id ).sum(:fueling)

		cargas - descargas
	end

	def name_with_fuel
		"#{self.name} (#{self.fuel_load} lts.)"
	end
end
