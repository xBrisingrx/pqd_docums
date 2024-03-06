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
#  unit_load           :integer          default("kilometers"), not null
#  hours_for_service   :integer
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

  validates :mileage_for_service,:hours_for_service,
    numericality: { only_integer: true, allow_nil: true }

  # I use this attribute to control with what type of unit we need measure to know when is the next vehicle service
  # no_apply means that in the fuel load form the input to kilometers doesn't required
  enum unit_load: %i( no_apply kilometers hours both )
  
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

  def status_service_mileages mileage_fuel_load = nil
    # verificamos si la unidad esta proxima a necesitar service
    # el aviso lo damos en vista documentos o al momento de cargar combustible, en el modal al colocar el km/hs avisamos 
    # si nos llega mileage_fuel_load significa que estamos cargando combustible
    next_service = self.vehicle_services.order(:date).order(:mileage).last
    if next_service.blank?
      if self.unit_load != 'no_apply'
        return 'A esta unidad no se le han hecho services.'
      else
        return ''
      end
    end

    last_load_fuel = ( mileage_fuel_load.nil? ) ? self.fuel_to_vehicles.order(:date)&.last&.mileage : mileage_fuel_load
    return '' if last_load_fuel.blank?

    mileage = next_service.mileage_next_service - last_load_fuel
    
    return 'Esta unidad tiene el service vencido' if mileage < 0
    #empezamos a avisar del service cuando le queda la mitad de km/hs que se necesitan
    if self.mileage_for_service > 0
      return "A esta unidad le faltan #{mileage} KM para el próximo service" if mileage <= self.mileage_for_service/2
      return '' if mileage > self.mileage_for_service/2
    end
  end

  def status_service_hours hours = nil
    next_service = self.vehicle_services.order(:date).order(:hours).last
    if next_service.blank?
      if self.unit_load != 'no_apply'
        return 'A esta unidad no se le han hecho services.'
      else
        puts "\n == a no apply \n"
        return ''
      end
    end

    last_load_fuel = ( hours.nil? ) ? self.fuel_to_vehicles.order(:date)&.last&.hours : hours
    puts "\n blank \n" if last_load_fuel.blank?
    return '' if last_load_fuel.blank?
    
    hours = next_service.hours_next_service - last_load_fuel
    
    return 'Esta unidad tiene el service vencido' if hours < 0
    #empezamos a avisar del service cuando le queda la mitad de km/hs que se necesitan
    if self.hours_for_service > 0
      return "A esta unidad le faltan #{hours} horas para el próximo service" if hours <= self.hours_for_service/2
      puts "\n hours > self.hours_for_service/2hours > self.hours_for_service/2 \n" if hours > self.hours_for_service/2
      return '' if hours > self.hours_for_service/2
    end
  end

  def status_service_ks_hs value = nil, unit_load = nil
    # tenemos que revisar por ambos a los vehiculos que se le cargan ambos datos ks y hs
    message = ''
    next_service = self.vehicle_services.order(:date).order(:id).last
    if next_service.blank?
      if self.unit_load != 'no_apply'
        return 'A esta unidad no se le han hecho services.'
      else
        return ''
      end
    end
    last_load_fuel = self.fuel_to_vehicles.order(:date).order(:id)
    if unit_load == 'kilometers'
      # se le esta haciendo una carga de combustible registrando kilometros
      kilometers_to_compare = ( value.nil? ) ? last_load_fuel&.last&.mileage : value
      hours_to_compare = ( last_load_fuel&.last&.hours ) ? last_load_fuel&.last&.hours : 0
    elsif unit_load == 'hours'
      # se le esta haciendo una carga de combustible registrando horas
      kilometers_to_compare = ( last_load_fuel&.last&.mileage ) ? last_load_fuel&.last&.mileage : 0
      hours_to_compare = ( value.nil? ) ? last_load_fuel&.last&.hours : value
    else
      # consulta desde documentos
      kilometers_to_compare = ( last_load_fuel&.last&.mileage ) ? last_load_fuel&.last&.mileage : 0
      hours_to_compare = ( last_load_fuel&.last&.hours ) ? last_load_fuel&.last&.hours : 0
    end

    if next_service.hours_next_service && hours_to_compare > 0
      hours_to_service = next_service.hours_next_service - hours_to_compare
    else
      # pongo un valor para que no explote la siguiente comparacion
      hours_to_service = 0
    end

    if next_service.mileage_next_service && kilometers_to_compare > 0
      km_to_service = next_service.mileage_next_service - kilometers_to_compare
    else
      # pongo un valor para que no explote la siguiente comparacion
      km_to_service = 0
    end


    if hours_to_service < 0 && unit_load == 'hours'
      message += "Esta unidad esta pasada de horas, tiene el service vencido."
    end

    if km_to_service < 0 && unit_load == 'kilometers'
      message += 'Esta unidad esta pasada de kilometraje, tiene el service vencido.'
    end

    if self.hours_for_service > 0 && hours_to_service > 0
      message += "A esta unidad le faltan #{hours_to_service} horas para el próximo service. \n" if hours_to_service <= self.hours_for_service/2
      message += '' if hours_to_service > self.hours_for_service/2
    end

    if self.mileage_for_service > 0 && km_to_service > 0
      message += "A esta unidad le faltan #{km_to_service} KM para el próximo service" if km_to_service <= self.mileage_for_service/2
      message += '' if km_to_service > self.mileage_for_service/2
    end
    return message
  end

  def check_service
    unit_load = self.unit_load
    if unit_load == 'both'
      msg = self.status_service_ks_hs
    end

    if unit_load == 'kilometers'
      msg = self.status_service_mileages
    end

    if unit_load == 'hours'
      msg = self.status_service_hours
    end
    return "#{msg}"
  end

  private
  def assign_douments
    documents = Document.where( d_type: 'vehicles', apply_to_all: true )
    documents.each do |document|
      AssignmentsDocument.create( assignated: self, document: document )
    end
  end

end
