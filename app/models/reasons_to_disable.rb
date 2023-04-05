# == Schema Information
#
# Table name: reasons_to_disables
#
#  id          :bigint           not null, primary key
#  d_type      :integer          not null
#  reason      :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ReasonsToDisable < ApplicationRecord
	enum d_type: {
		people: 1, 
		vehicles: 2
	}
	scope :actives, -> { where(active: true) }
	scope :poeple, -> { where(d_type: :poeple) }
	scope :vehicules, -> { where(d_type: :vehicles) }
end
