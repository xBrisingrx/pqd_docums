# == Schema Information
#
# Table name: cost_centers
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CostCenter < ApplicationRecord
	validates :name, presence: true
end
