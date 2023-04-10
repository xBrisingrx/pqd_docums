class FuelSupplier < ApplicationRecord
	enum d_type: {
		people: 1, 
		vehicles: 2
	}

	scope :actives, -> { where(active: true) }
end
