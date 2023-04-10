# == Schema Information
#
# Table name: clothes
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Clothe < ApplicationRecord
	has_many :clothes_packs
	has_many :clothing_packages, through: :clothes_packs

	validates :name, presence: true, 
		uniqueness: { case_sensitive: false, message: "Ya existe una prenda registrada con este nombre" }


	after_create :create_individual_clothing_packages
	scope :actives, -> { where(active: true) }

	def create_individual_clothing_packages
		clothing_package = ClothingPackage.create( name: "#{self.name}", 
			days_of_validity: 0,
			one_clothes: true,
			expires: false, active: true )
		clothing_package.clothes_packs.create( clothe_id: self.id )
	end

	def disable current_user
		ActiveRecord::Base.transaction do
			self.clothes_packs.actives.each do |entry|
				entry.update!(active: false)
				ActivityHistory.create( action: :disable, description: "Se quito la prenda #{self.name} del paquete #{entry.clothing_package.name} por dar de baja la prenda.", 
	      record: entry, date: Time.now, user: current_user )
			end
			self.update!(active: false)
		end
	end

end
