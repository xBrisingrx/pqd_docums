class PeopleClothe < ApplicationRecord
  belongs_to :person
  belongs_to :clothing_package
end
