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
#  fueling             :decimal(15, 2)   not null
#  mileage             :decimal(15, 2)   not null
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
  after_create :verify_if_exist_closure
  after_create :create_closure_ticket
  before_update :update_ticket

  validates :mileage, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validate :valid_dates
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
      ticket.check_ticket_book_is_completed
    end

    # def valid_dates
    #   closure_date = Closure.last_date
    #   if (!closure_date.nil?) && closure_date > self.computable_date
    #     errors.add(:computable_date, "No puede ingresar una fecha anterior al ultimo cierre.")
    #   end
    # end

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
        ticket.check_ticket_book_is_completed
        set_ticket_to_used
      end
    end

    def verify_if_exist_closure
      # si cargamos combustible de un periodo donde no existe un cierre , hay que crear el cierre
      closure = Closure.where( 'start_date <= ?', self.date ).where( 'end_date >= ?', self.date )
      if closure.blank?
        if self.date.day < 26 
          start_date = self.date - 1.month  
          end_date = self.date
        else
          start_date = self.date 
          end_date = self.date + 1.month 
        end

        Closure.create(
          start_date: Date.new( start_date.year, start_date.month, 26 ),
          end_date: Date.new( end_date.year, end_date.month, 25 ),
          name: "Cierre periodo #{I18n.t("date.month_names")[start_date.month]} #{start_date.year}")
      end
    end

    def create_closure_ticket
      closure = Closure.where( 'start_date <= ?', self.date ).where( 'end_date >= ?', self.date ).first
      ClosureTicket.create( closure: closure, ticket: self.ticket )
      if closure.was_send?
        ticket = Ticket.find(self.ticket.id)
        ticket.update( closed: true )
      end
    end

end
