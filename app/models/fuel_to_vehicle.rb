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
#  ticket              :bigint           not null
#  fuel_type           :integer          default("gasoil")
#  active              :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  cost_center_id      :bigint
#
class FuelToVehicle < ApplicationRecord
  belongs_to :vehicle
  belongs_to :fuel_supplier
  belongs_to :person_authorize, class_name: "Person"
  belongs_to :person_load, class_name: "Person"
  belongs_to :cost_center

  validates :ticket, uniqueness: { message: 'Este número de ticket ya se encuentra registrado.' }

  before_validation :set_cost_center, on: :create

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

end
