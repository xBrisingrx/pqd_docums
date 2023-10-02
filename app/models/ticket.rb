# == Schema Information
#
# Table name: tickets
#
#  id             :bigint           not null, primary key
#  number         :integer          not null
#  used           :boolean          default(FALSE)
#  active         :boolean          default(TRUE)
#  ticket_book_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  closed         :boolean          default(FALSE)
#
class Ticket < ApplicationRecord
	belongs_to :ticket_book
	has_one :fuel_to_vehicle

	validates :number, 
		presence: true, 
		numericality: { only_integer: true }

	scope :unused, -> { where(used: false) }

	def check_ticket_book_is_completed
		self.ticket_book.check_is_completed
	end
end
