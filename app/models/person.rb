# == Schema Information
#
# Table name: people
#
#  id                  :bigint           not null, primary key
#  file                :integer          not null
#  name                :string(255)      not null
#  last_name           :string(255)      not null
#  dni                 :string(255)
#  tramit_number       :bigint
#  cuil                :string(255)
#  email               :string(255)
#  dni_has_expiration  :boolean          default(TRUE)
#  expiration_dni_date :date
#  birth_date          :date
#  nationality         :string(255)      default("")
#  direction           :string(255)
#  phone               :string(255)
#  start_activity      :date
#  active              :boolean          default(TRUE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  can_authorize       :boolean          default(FALSE)
#
class Person < ApplicationRecord
  has_one_attached :dni_file
  has_one_attached :cuil_file
  has_one_attached :start_activity_file
  has_many :assignments_profiles, as: :assignated # relacion entre perfil y persona
  has_many :profiles, through: :assignments_profiles
  has_many :assignments_documents, as: :assignated
  has_many :documents, through: :assignments_documents
  has_many :activity_histories, as: :record
  has_many :people_clothes
  has_many :clothes, through: :people_clothes

  validates :file, presence: true, uniqueness: { message: "Este legajo pertenece a otra persona" }
  validates :name, presence: true, length: { minimum: 3, too_short: "Minimo son %{count} caracteres." }
  validates :last_name, presence: true, length: { minimum: 3, too_short: "Minimo son %{count} caracteres." }
  validates :dni, uniqueness: { message: "Este dni pertenece a otra persona" },
    allow_blank: true,
    length: { minimum: 8, too_short: "Minimo son %{count} caracteres." }
  validates :email,
    uniqueness: { case_sensitive: false, message: "El email ya se encuentra en uso" }, 
    allow_blank: true,
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }
    
	validates :tramit_number, uniqueness: { message: "Este número de tramite pertenece a otra persona" }, 
	    allow_blank: true

  after_create :assign_douments

  scope :actives, -> { where(active: true) }
  scope :inactives, -> { where(active: false) }

  def fullname
    "#{self.last_name} #{self.name}"  
  end

  def enable
    self.update(active: true)
  end

  private
  def assign_douments
    documents = Document.where( d_type: 'people', apply_to_all: true )
    documents.each do |document|
      AssignmentsDocument.create( assignated: self, document: document )
    end
  end

end
