# == Schema Information
#
# Table name: documents_profiles
#
#  id          :bigint           not null, primary key
#  d_type      :integer          not null
#  profile_id  :bigint
#  document_id :bigint
#  start_date  :date
#  end_date    :date
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class DocumentsProfile < ApplicationRecord
  # Documents in profile
  belongs_to :profile
  belongs_to :document

  validate :unique_association, on: :create

  validates :end_date, presence: { message: 'Para dar de baja un documento se necesita ingresar la fecha de finalización.'}, if: :document_profile_inactive?
  
  scope :actives, -> { where(active: true) }

  after_create :assign_document 

  enum d_type: {
    people: 1, 
    vehicles: 2
  }
  
  def assignment_documents_to_profile 
    entry = DocumentsProfile.find_by(profile_id: self.profile_id, document_id: self.document_id)
    if entry.nil? 
      self.save 
    elsif !entry.active?
      entry.update(start_date: self.start_date, active: true)
    else
      raise StandardError.new 'Ya tiene asignado el documento' 
    end
  end

  def update_asociations
    # Si le asigno un documento a un perfil se debe asignar dichos documentos a los asociados
    @documents = DocumentsProfile.where( profile_id: self.profile_id ).actives
    @assigned_profile = AssignmentsProfile.where(profile_id: self.profile_id).actives

    ActiveRecord::Base.transaction do
      @assigned_profile.each do |assignated|
        @documents.each do |document|
          @entry = AssignmentsDocument.find_by( assignated_id: assignated.assignated_id, 
            assignated_type: assignated.assignated_type, 
            document_id: document.document_id)
          if @entry.nil?
            @entry = AssignmentsDocument.create(assignated: assignated.assignated, document_id: document.document_id)
          elsif !@entry.active && !@entry.custom
            # La persona pudo haber tenido un perfil con este documento y se dio de baja la relacion
            # La persona pudo haber tenido un perfil con este documento y al perfil se le quito el documento
            # Los documentos des/asignados manualmente (custom) no se pueden alterar
            @entry.update(active: true)
          end
        end
      end
    end
  end

  private 

  def assign_document
    # Si al perfil se le agregar un documento hay que revisar los registros asociados
    assginateds = AssignmentsProfile.where( profile_id: self.profile_id )
    ActiveRecord::Base.transaction do
      assginateds.each do |assignated|
        entry = AssignmentsDocument.find_by( assignated_id: assignated.assignated_id, 
                                             assignated_type: assignated.assignated_type,
                                             document_id: self.document_id )
        if entry.nil?
          assignated_document = AssignmentsDocument.create(assignated_id: assignated.assignated_id, 
                                             assignated_type: assignated.assignated_type,
                                             document_id: self.document_id)
        elsif !entry.custom && !entry.active
          entry.update( active: true )
        end
      end
    end
  end

  def document_profile_inactive?
    self.active == false
  end

  def unique_association
    # este error deberia disparar una ventana q pregunte si quieren reactivar la asociacion
    # lo puse sobre campo active para identificar el error a la hora de mostarlo en pantalla
    @entry = DocumentsProfile.find_by(profile_id: self.profile_id, document_id: self.document_id)
    if !@entry.nil? && @entry.active
      errors.add(:uniqueness, "Este perfil ya tiene asignado el atributo.")
      # self.errors[:base] << "El perfil ya tiene este atributo"
    elsif !@entry.nil? && !@entry.active
      errors.add(:base, "Este perfil ya tiene asignado el atributo, se encuentra dado de baja")
    end
  end
  
end
