# == Schema Information
#
# Table name: assignments_documents
#
#  id              :bigint           not null, primary key
#  assignated_type :string(255)
#  assignated_id   :bigint
#  document_id     :bigint
#  start_date      :date
#  end_date        :date
#  custom          :boolean          default(FALSE)
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class AssignmentsDocument < ApplicationRecord
  belongs_to :assignated, polymorphic: true
  belongs_to :document
  has_many :document_renovations

  accepts_nested_attributes_for :document_renovations

  # validate :unique_association, on: :create
  validates :document_id, uniqueness: { scope: [:assignated_id, :assignated_type], message: 'El documento ya se encuentra asignado' }

  scope :actives, -> { where(active: true) }

  def disable
    if !document_is_shared_with_other_profile? && !self.custom
      self.update!( active: false )
    end
  end

  def document_is_shared_with_other_profile?
    #checkeo si los perfiles que tiene esta persona comparten el atributo
    @count = 0
    self.assignated.assignments_profiles.where(active: true).each do |p|
      if !DocumentsProfile.find_by(profile_id: p.profile_id, document_id: self.document_id, active: true).nil?
        @count +=1
      end
    end
    return @count > 1
  end

  def last_renovation
    self.document_renovations.actives.order(expiration_date: :DESC).first
  end

  def has_renovations?
    self.document_renovations.actives.count > 0
  end

  def assign
    entry = AssignmentsDocument.where(assignated_id: self.assignated_id, assignated_type: self.assignated_type ,document_id: self.document_id)
    if entry.empty?
      self.save
    elsif !entry.first.active 
      entry.update(active: true, custom: self.custom)
    elsif entry.active 
      self.errors.add(:base, "Ya tiene asignado este documento.")
    else 
      self.errors.add(:base, "No se puede realizar esta asignacion.")
    end
  end

  private
  def unique_association
    entry = AssignmentsDocument.find_by(assignated_id: self.assignated_id, assignated_type: self.assignated_type ,document_id: self.document_id)
    if !entry.nil? && entry.active
        errors.add(:uniqueness, "Ya tiene asignado este documento.")
    end
  end

end
