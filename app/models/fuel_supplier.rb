# == Schema Information
#
# Table name: fuel_suppliers
#
#  id             :bigint           not null, primary key
#  name           :string(255)      not null
#  description    :string(255)
#  supplier_type  :integer          not null
#  fuel_unlimited :boolean          default(FALSE)
#  active         :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class FuelSupplier < ApplicationRecord
	has_many :fuel_loads

	enum supplier_type: {
		supplier: 1, 
		service_station: 2
	}

	scope :actives, -> { where(active: true) }

	before_create :set_unlimited

	def set_unlimited
		self.fuel_unlimited = self.service_station?
	end

	def fuel_load
		if self.fuel_unlimited?
			"∞"
		else
			cargas = self.fuel_loads.sum(:fueling)
			descargas = FuelToVehicle.where( fuel_supplier_id: self.id ).sum(:fueling)

			cargas - descargas
		end
	end

	def name_with_fuel
		if self.supplier?
			"#{self.name} (#{self.fuel_load} lts.)"
		else
			"#{self.name}"
		end
	end

	def name_supplier_type
		name = (self.supplier_type == 'supplier') ? 'Abastecedor' : 'Estación de servicio'
		name
	end
end
