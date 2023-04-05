# == Schema Information
#
# Table name: vehicle_insurances
#
#  id           :bigint           not null, primary key
#  vehicle_id   :bigint
#  insurance_id :bigint
#  policy       :string(255)      not null
#  start_date   :date
#  end_date     :date
#  description  :string(255)
#  active       :boolean          default(TRUE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class VehicleInsurance < ApplicationRecord
  belongs_to :vehicle
  belongs_to :insurance
  has_many_attached :file

  scope :actives, -> { where(active: true) }
  
end
