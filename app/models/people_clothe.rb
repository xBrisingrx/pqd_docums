# == Schema Information
#
# Table name: people_clothes
#
#  id                  :bigint           not null, primary key
#  person_id           :bigint
#  clothing_package_id :bigint
#  description         :text(65535)
#  start_date          :date
#  end_date            :date
#  active              :boolean          default(TRUE)
#  expires             :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class PeopleClothe < ApplicationRecord
  belongs_to :person
  belongs_to :clothing_package

  scope :actives, -> { where( active: true ) }
end
