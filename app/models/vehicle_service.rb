# == Schema Information
#
# Table name: vehicle_services
#
#  id                   :bigint           not null, primary key
#  date                 :date             not null
#  vehicle_id           :bigint
#  mileage              :integer
#  mileage_next_service :integer
#  comment              :text(65535)
#  active               :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  hours                :integer
#  hours_next_service   :integer
#
class VehicleService < ApplicationRecord
  belongs_to :vehicle

  scope :actives, ->{ where(active: true) }

  validates :date, presence: true 
  validates :mileage, :mileage_next_service,:hours, :hours_next_service, numericality: { only_integer: true, allow_nil: true }
  validate :mileage_or_hours_required
  validate :valid_mileages
  validate :valid_hours
  validate :greater_than_last_mileage, on: :create 

  private 
    def greater_than_last_mileage
      last_mileage = VehicleService.where( vehicle_id: self.vehicle_id ).where( 'date <= ?', self.date ).order( date: :asc ).last
      if !last_mileage.blank? && last_mileage.mileage >= self.mileage
        errors.add(:mileage, "Los KM son menores al último service registrado en la fecha #{ last_mileage.date.strftime('%d-%m-%y') }")
      end
    end

    def greater_than_last_hours
      last_hours = VehicleService.where( vehicle_id: self.vehicle_id ).where( 'date <= ?', self.date ).order( date: :asc ).last
      if !last_hours.blank? && last_hours.hours >= self.hours
        errors.add(:hours, "Las HS son menores al último service registrado en la fecha #{ last_hours.date.strftime('%d-%m-%y') }")
      end
    end

    def valid_mileages
      if !self.mileage.blank? && !self.mileage_next_service.blank?
        errors.add(:mileage_next_service, "Los siguientes KS no pueden ser menores a las actuales") if ( self.mileage >= self.mileage_next_service )
      end
    end

    def valid_hours
      if !self.hours.blank? && !self.hours_next_service.blank?
        errors.add(:hours_next_service, "Las siguientes HS no pueden ser menores a las actuales") if ( self.hours >= self.hours_next_service )
      end
    end

    def mileage_or_hours_required
      unit_load = self.vehicle.unit_load
      if unit_load == 'kilometers'
        if self.mileage.blank? || self.mileage_next_service.blank?
          errors.add(:mileage, "Debe ingresar los kilometros actuales") if self.mileage.blank?
          errors.add(:mileage_next_service, "Debe ingresar los kilometros del próximo service") if self.mileage_next_service.blank?
        end
      end
      if unit_load == 'hours'
        if self.hours.blank? || self.hours_next_service.blank?
          errors.add(:hours, "Debe ingresar las horas actuales") if self.hours.blank?
          errors.add(:hours_next_service, "Debe ingresar las horas del próximo service") if self.hours_next_service.blank?
        end
      end

      if unit_load == 'both' || unit_load == 'no_apply'
        # Todo este lio para asegurarnos de que si ingresa km u horas, debe ir si o si prox km o prox hs
        if !self.mileage.blank? && self.mileage_next_service.blank?
          errors.add(:mileage, "Debe ingresar los kilometros actuales") if self.mileage.blank?
          errors.add(:mileage_next_service, "Debe ingresar los kilometros del próximo service") if self.mileage_next_service.blank?
        end

        if self.mileage.blank? && !self.mileage_next_service.blank?
          errors.add(:mileage, "Debe ingresar los kilometros actuales") if self.mileage.blank?
          errors.add(:mileage_next_service, "Debe ingresar los kilometros del próximo service") if self.mileage_next_service.blank?
        end

        if !self.hours.blank? && self.hours_next_service.blank?
          errors.add(:hours, "Debe ingresar las horas actuales") if self.hours.blank?
          errors.add(:hours_next_service, "Debe ingresar las horas del próximo service") if self.hours_next_service.blank?
        end

        if self.hours.blank? && !self.hours_next_service.blank?
          errors.add(:hours, "Debe ingresar las horas actuales") if self.hours.blank?
          errors.add(:hours_next_service, "Debe ingresar las horas del próximo service") if self.hours_next_service.blank?
        end

        if self.mileage.blank? && self.mileage_next_service.blank? && self.hours.blank? && self.hours_next_service.blank?
          errors.add(:mileage, "Debe ingresar KM u HS")
          errors.add(:mileage_next_service, "Debe ingresar KM u HS")
          errors.add(:hours, "Debe ingresar KM u HS")
          errors.add(:hours_next_service, "Debe ingresar KM u HS")
        end
      end
    end
end
