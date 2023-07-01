# == Schema Information
#
# Table name: fuel_to_vehicles
#
#  id                  :bigint           not null, primary key
#  vehicle_id          :bigint
#  fuel_supplier_id    :bigint
#  person_load_id      :bigint
#  person_authorize_id :bigint
#  date                :date             not null
#  fueling             :decimal(10, )    not null
#  mileage             :bigint           not null
#  fuel_type           :integer          default("gasoil")
#  active              :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  cost_center_id      :bigint
#  ticket_id           :bigint
#  computable_date     :date
#
class FuelToVehicle < ApplicationRecord
  belongs_to :vehicle
  belongs_to :fuel_supplier
  belongs_to :person_authorize, class_name: "Person"
  belongs_to :person_load, class_name: "Person"
  belongs_to :cost_center
  belongs_to :ticket
  has_one :ticket_book, through: :ticket

  before_validation :set_cost_center, on: :create
  after_create :set_ticket_to_used
  before_update :update_ticket

  validates :mileage, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :valid_dates
  validate :greater_than_last_mileage, on: :create 
  
  scope :actives, -> { where(active: true) }

  enum fuel_type: {
    gasoil: 1, 
    nafta: 2
  }

  def fuel_type_name
    if self.gasoil?
      "GAS OIL"
    else
      "Nafta"
    end
  end

  private 
    def set_cost_center
      self.cost_center_id = 1
    end

    def set_ticket_to_used
      ticket = Ticket.find( self.ticket.id )
      ticket.update(used: true)
    end

    def valid_dates
      closure_date = Closure.last_date
      if (!closure_date.nil?) && closure_date > self.computable_date
        errors.add(:computable_date, "No puede ingresar una fecha anterior al ultimo cierre.")
      end
    end

    def greater_than_last_mileage
      last_mileage = FuelToVehicle.where( vehicle_id: self.vehicle_id ).order( date: :asc ).last
      if !last_mileage.nil? && last_mileage.mileage >= self.mileage
        errors.add(:mileage, "El ultimo kilometraje registrado de esta unidad es de #{last_mileage.mileage}")
      end
    end

    def update_ticket
      if self.ticket_id_changed?
        # lo instancio porque sino toma que se actualiza fuel_to_vehicle y genera un loop infinito
        ticket = Ticket.find( self.ticket_id_was )
        ticket.update( used: false )
        set_ticket_to_used
      end
    end

end
