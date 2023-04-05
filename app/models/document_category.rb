# == Schema Information
#
# Table name: document_categories
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  description :string(255)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class DocumentCategory < ApplicationRecord
	has_many :documents

	validates :name, presence: true, 
		uniqueness: { message: "Ya existe una categoría registrada con este nombre" }
	scope :actives, -> { where(active: true) }
end
