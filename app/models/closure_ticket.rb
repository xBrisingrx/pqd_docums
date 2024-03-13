# == Schema Information
#
# Table name: closure_tickets
#
#  id         :bigint           not null, primary key
#  closure_id :bigint
#  ticket_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ClosureTicket < ApplicationRecord
  belongs_to :closure, dependent: :destroy
  belongs_to :ticket
end
