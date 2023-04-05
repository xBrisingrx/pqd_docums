# == Schema Information
#
# Table name: assignments_profiles
#
#  id                  :bigint           not null, primary key
#  assignated_type     :string(255)
#  assignated_id       :bigint
#  start_date          :date
#  end_date            :date
#  active              :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  profile_id :bigint
#
class AssignmentsProfile < ApplicationRecord
  belongs_to :assignated, polymorphic: true
  belongs_to :profile
  has_many :documents, through: :profile

  # validate :unique_association, on: :create
  validates :start_date, presence: true
  validates :profile_id, uniqueness: {
    scope: [ :assignated_type, :assignated_id ], message: 'La asignacion ya existe.'
  }
  after_create :assign_documents

  scope :actives, ->{ where(active:true) }
  scope :people, ->{ where( assignated_type: :person ) }
  scope :vehicles, ->{ where( assignated_type: :vehicle ) }

  # def self.active_profiles
  #   self.joins(:zone_job_profile).where(zone_job_profile: { active: true })
  # end

  def assign_documents
    # Si le asigno un perfil a una persona tengo que tambien asociarles los documentos que tiene el perfil
    # Obtengo los documentos que tiene el perfil
    # @documents = DocumentsProfile.where( profile_id: self.profile_id, active: true )
    @documents = DocumentsProfile.where( profile_id: self.profile_id, active: true )
    ActiveRecord::Base.transaction do
      @documents.each do |document|
        @entry = AssignmentsDocument.find_by( assignated: self.assignated,
          document_id: document.document_id)
        if @entry.nil?
          AssignmentsDocument.create(assignated: self.assignated, document_id: document.document_id, start_date: self.start_date)
        elsif !@entry.active && !@entry.custom
          # La persona pudo haber tenido un perfil con este documento y se dio de baja la relacion
          # La persona pudo haber tenido un perfil con este documento y al perfil se le quito el documento
          # Los documentos des/asignados manualmente (custom) no se pueden alterar
          @entry.update(active: true)
        end
      end
    end
  end

  def shared_document document_id
    profiles = AssignmentsProfile.where( assignated: self.assignated ).actives
    count = 0
    profiles.each do |profile|
      document = profile.zone_job_profile.zone_job_profile_docs.where(document_id: document_id, active: true)
      puts "\n\n #{ document } \n\n"
      if !document.empty?
        count += 1
      end
    end
    return count > 1
  end

  def disable end_date
    # busco mis documentos asociados al perfil a deshabilitar
    # deshabilito los que se puedan, si se comparte con otro perfil o es custom no se puede
    # deshabilito el perfil
    @documents = DocumentsProfile.where( profile_id: self.profile_id ).actives
    ActiveRecord::Base.transaction do 
      @documents.each do |document|
        assigned_document = AssignmentsDocument.where( assignated_id: self.assignated_id, 
            assignated_type: self.assignated_type, 
            document_id: document.document_id,
            custom: false)
        if !assigned_document.empty? && !self.shared_document(document.document_id)
          assigned_document.first.update( active: false, end_date: end_date )
        end
      end
      self.update!(active: false, end_date: end_date) 
    end
  end

  def reactive_profile start_date
    @documents = DocumentsProfile.where( profile_id: self.profile_id ).actives
    ActiveRecord::Base.transaction do 
      @documents.each do |document|
        assigned_document = AssignmentsDocument.where( assignated_id: self.assignated_id, 
            assignated_type: self.assignated_type, 
            document_id: document.document_id)
        if assigned_document.empty?
          AssignmentsDocument.create( assignated: self.assignated, 
            document_id: document.document_id, 
            custom: false,
            start_date: start_date )
        elsif !self.shared_document(document.document_id)
          assigned_document.first.update( active: true )
        end
      end
      self.update!(active: true, start_date: start_date) 
    end
  end

  private
  def unique_association
    @entry = AssignmentsProfile.find_by(assignated_id: self.assignated_id, assignated_type: self.assignated_type,
        profile_id: self.profile_id)
    if self.id.nil? 
      # Validacion para creacion
      if !@entry.nil? && @entry.active
        errors.add(:uniqueness, "La asignacion ya existe.")
      elsif !@entry.nil? && !@entry.active
        errors.add(:uniqueness, "La asignacion ya existe, se encuentra dada de baja.")
      end
    end
  end
end
