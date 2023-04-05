# == Schema Information
#
# Table name: expiration_types
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  days        :integer
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ExpirationType < ApplicationRecord
	has_many :documents 
	
	validates :name, presence: true, 
		uniqueness: { message: "Ya existe un tipo de expiración registrado con este nombre" }
	scope :actives, -> { where(active: true) }
end
