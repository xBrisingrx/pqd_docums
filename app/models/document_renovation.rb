# == Schema Information
#
# Table name: document_renovations
#
#  id                      :bigint           not null, primary key
#  assignments_document_id :bigint
#  renovation_date         :date
#  expiration_date         :date
#  active                  :boolean          default(TRUE)
#  comment                 :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class DocumentRenovation < ApplicationRecord
	has_many_attached :file
	belongs_to :assignments_document
	has_one :document, through: :assignments_document

	validates :renovation_date, presence: {message: 'Debe ingresar la fecha de renovación'}, if: :document_expire?
	validates :expiration_date, presence: {message: 'Debe ingresar la fecha de expiración'}, if: :document_expire?

	scope :actives, ->{ where(active:true) }

	def document_expire?
		assignments_document = AssignmentsDocument.find self.assignments_document_id
		assignments_document.document.expires
	end

	def disable
		self.update(active:false)
	end
end
