# == Schema Information
#
# Table name: fuel_to_vehicles
#
#  id           :bigint           not null, primary key
#  vehicle_id   :bigint
#  fuel_truk_id :bigint
#  date         :string(255)      not null
#  fueling      :decimal(10, )    not null
#  mileage      :bigint           not null
#  active       :boolean          default(TRUE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class FuelToVehicle < ApplicationRecord
  belongs_to :vehicle
  belongs_to :fuel_truk
end
