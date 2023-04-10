# == Schema Information
#
# Table name: fuel_loads
#
#  id         :bigint           not null, primary key
#  fueling    :decimal(10, )    not null
#  date       :date             not null
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FuelLoad < ApplicationRecord
end
