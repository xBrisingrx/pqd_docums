# == Schema Information
#
# Table name: insurances
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Insurance < ApplicationRecord
	has_many :vehicle_insurances
	has_many :vehicles, through: :vehicle_insurances
	
	
	accepts_nested_attributes_for :vehicle_insurances

	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "Ya existe una aseguradora registrada con este nombre" }

	scope :actives, -> { where(active: true) }

	def disable current_user
		ActiveRecord::Base.transaction do
			self.vehicle_insurances.each do |vehicle_insurance|
				vehicle_insurance.update( active: false )
				ActivityHistory.create( action: :disable, 
					description: "Seguro desvinculado al eliminar la aseguradora #{self.name}", 
	      	record: vehicle_insurance, date: Time.now, user: current_user )
			end
			self.update(active: false)
		end
	end
end
