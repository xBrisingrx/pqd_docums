# == Schema Information
#
# Table name: vehicles
#
#  id                  :bigint           not null, primary key
#  code                :string(255)      not null
#  domain              :string(255)
#  chassis             :string(255)
#  engine              :string(255)
#  year                :integer          default(0)
#  observations        :text(65535)
#  active              :boolean          default(TRUE)
#  is_company          :boolean          default(TRUE)
#  vehicle_type_id     :bigint
#  vehicle_model_id    :bigint
#  vehicle_location_id :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  mileage_for_service :bigint
#  unit_load           :integer          default(1), not null
#
class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  belongs_to :vehicle_model
  belongs_to :vehicle_location
  has_one :vehicle_brand, through: :vehicle_model
  has_many :assignments_profiles, as: :assignated,dependent: :destroy # relacion entre perfil y vehiculo
  has_many :profiles, through: :assignments_profiles
  has_many :assignments_documents, as: :assignated, dependent: :destroy
  has_many :documents, through: :assignments_documents
  has_many :activity_histories, as: :record, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many :vehicle_insurances, dependent: :destroy
  has_many :vehicle_services, dependent: :destroy # services hechos al vehiculo
  has_many :fuel_to_vehicles, dependent: :destroy # son las cargas de combustible

  after_create :assign_douments

  scope :actives, -> { where(active: true) }
  scope :inactives, -> { where(active: false) }

  validates :mileage_for_service, numericality: { only_integer: true, allow_nil: true }

  # I use this attribute to control with what type of unit we need measure to know when is the next vehicle service
  enum unit_load: %i( dont_apply kilometers hours both )
  
  def brand
    self.vehicle_model.vehicle_brand.name
  end

  def disable end_date
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

  def status_mileage_for_service mileage_fuel_load = nil
    # verificamos si la unidad esta proxima a necesitar service
    # el aviso lo damos en vista documentos o al momento de cargar combustible, en el modal al colocar el km/hs avisamos 
    # si nos llega mileage_fuel_load significa que estamos cargando combustible
    next_service = self.vehicle_services.order(:date).last
    last_load_fuel = ( mileage_fuel_load.nil? ) ? self.fuel_to_vehicles.order(:date)&.last&.mileage : mileage_fuel_load
    return '' if next_service.blank?
    return '' if last_load_fuel.blank?

    mileage = next_service.mileage_next_service - last_load_fuel
    
    return 'Esta unidad tiene el service vencido' if mileage < 0
    #empezamos a avisar del service cuando le queda la mitad de km/hs que se necesitan
    return "A esta unidad le faltan #{mileage} KM/HS para el próximo service" if mileage <= self.mileage_for_service/2

    return '' if mileage > self.mileage_for_service/2  
  end

  private
  def assign_douments
    documents = Document.where( d_type: 'vehicles', apply_to_all: true )
    documents.each do |document|
      AssignmentsDocument.create( assignated: self, document: document )
    end
  end

end
