# == Schema Information
#
# Table name: vehicles
#
#  id                  :bigint           not null, primary key
#  code                :string(255)      not null
#  domain              :string(255)
#  chassis             :string(255)
#  engine              :string(255)
#  seats               :string(255)
#  year                :integer          default(0)
#  observations        :text(65535)
#  active              :boolean          default(TRUE)
#  vehicle_type_id     :bigint
#  vehicle_model_id    :bigint
#  vehicle_location_id :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  belongs_to :vehicle_model
  belongs_to :vehicle_location
  has_one :vehicle_brand, through: :vehicle_model
  has_many :assignments_profiles, as: :assignated # relacion entre perfil y vehiculo
  has_many :profiles, through: :assignments_profiles
  has_many :assignments_documents, as: :assignated
  has_many :documents, through: :assignments_documents
  has_many :activity_histories, as: :record
  has_many_attached :images
  has_many :vehicle_insurances
  has_many :FuelToVehicles # son las cargas de combustible

  scope :actives, -> { where(active: true) }
  scope :inactives, -> { where(active: false) }
  
  def brand
    self.vehicle_model.vehicle_brand.name
  end

  def disable end_date
    pp end_date
    ActiveRecord::Base.transaction do
      self.update(active: false)
      self.assignments_profiles.where(active: true).each do |profile|
        profile.update(active: false, end_date: end_date)
      end
      self.assignments_documents.where(active: true).each do |document|
        document.update(active: false, end_date: end_date)
      end
    end
  end

  def enable
    self.update(active: true)
  end
end
