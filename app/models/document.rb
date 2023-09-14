# == Schema Information
#
# Table name: documents
#
#  id                      :bigint           not null, primary key
#  d_type                  :integer          not null
#  name                    :string(255)      not null
#  description             :string(255)
#  expires                 :boolean          default(FALSE)
#  days_of_validity        :integer          default(0)
#  allow_modify_expiration :boolean          default(FALSE)
#  observations            :text(65535)
#  renewal_methodology     :text(65535)
#  monthly_summary         :boolean          default(TRUE)
#  start_date              :date
#  end_date                :date
#  active                  :boolean          default(TRUE)
#  document_category_id    :bigint
#  expiration_type_id      :bigint
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  apply_to_all            :boolean          default(FALSE)
#
class Document < ApplicationRecord
	# la expiracion la manejo con una tabla expiration_type, en base a esa tabla sacamos cuantos dias vale el documento
	# tengo explicito un campo de dias xq si eligen "personalizado" deben seterar la cantidad de dias a mano
	# en caso de actualizar los dias de cada tipo de expiracion se va a actualizar en todos los documentos
	belongs_to :document_category
	belongs_to :expiration_type, optional: true

	validates :name, presence: true, 
		uniqueness: { scope: :d_type, case_sensitive: false, message: "Este documento ya se encuentra registrado" }
	validates :d_type, presence: true

	validates :days_of_validity, numericality: { only_integer: true, message: 'Debe ingresar un número.' },
		presence: { message: 'Debe ingresar los días de duración del atributo.' }, if: :document_expire?

	validates :expiration_type_id, presence: { message: 'Seleccione un periodo de vencimiento'}, if: :document_expire?

	validates :end_date, presence: { message: 'Para dar de baja un documento se necesita ingresar la fecha de finalización.'}, if: :document_inactive?

	before_create :set_data_if_no_expire

	after_save :check_apply_to_all

	enum d_type: {
		people: 1, 
		vehicles: 2
	}

	scope :actives, -> { where(active: true) }

	private 

	def set_data_if_no_expire
		if !self.expires?
			expiration_type = ExpirationType.where(active: false, name: 'No vence').first
			self.expiration_type_id = expiration_type.id
		end
	end

	def document_expire?
		self.expires?
	end

	def document_inactive?
		!self.active
	end

	def check_apply_to_all
		if self.apply_to_all
			set_document_to_all
		end
	end

	def set_document_to_all
		if self.d_type == 'people'
			assignateds = Person.actives
		else
			assignateds = Vehicle.actives
		end
		assignateds.each do |assignated|
			assignment_document = AssignmentsDocument.where( document: self, assignated: assignated ).first 
			if assignment_document.blank?
				assignated.assignments_documents.create( document: self, start_date: self.start_date )
			end
		end
	end

end
