class FuelSupplier < ApplicationRecord
	has_many :fuel_loads
	enum supplier_type: {
		supplier: 1, 
		service_station: 2
	}

	scope :actives, -> { where(active: true) }

	before_create :set_unlimited

	def set_unlimited
		self.unlimited = self.supplier_type == :service_station
	end

	def fuel_load
		cargas = self.fuel_loads.sum(:fueling)
		descargas = FuelToVehicle.where( fuel_truk_id: self.id ).sum(:fueling)

		cargas - descargas
	end

	def name_with_fuel
		"#{self.name} (#{self.fuel_load} lts.)"
	end
end
