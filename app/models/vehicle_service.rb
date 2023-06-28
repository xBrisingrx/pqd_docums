# == Schema Information
#
# Table name: vehicle_services
#
#  id                   :bigint           not null, primary key
#  date                 :date             not null
#  vehicle_id           :bigint
#  mileage              :bigint           not null
#  mileage_next_service :bigint           not null
#  comment              :text(65535)
#  active               :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class VehicleService < ApplicationRecord
  belongs_to :vehicle

  scope :actives, ->{ where(active: true) }

  validates :date, :mileage, :mileage_next_service, presence: true 
  validates :mileage, :mileage_next_service, numericality: { only_integer: true }

  validate :greater_than_last_mileage, on: :create 
  validate :valid_mileages

  private 
    def greater_than_last_mileage
      last_mileage = VehicleService.where( vehicle_id: self.vehicle_id ).where( 'date <= ?', self.date ).order( date: :asc ).last
      if !last_mileage.blank? && last_mileage.mileage >= self.mileage
        errors.add(:mileage, "Los KM/HS son menores al service registrado en la fecha #{ last_mileage.date.strftime('%d-%m-%y') }")
      end
    end

    def valid_mileages
      errors.add(:mileage_next_service, "Las siguientes KM/HS no pueden ser menores a las actuales") if ( self.mileage >= self.mileage_next_service )
    end
end
