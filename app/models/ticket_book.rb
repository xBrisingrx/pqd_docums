# == Schema Information
#
# Table name: ticket_books
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#
class TicketBook < ApplicationRecord
	has_many :tickets

	validates :name, 
		presence: true, 
		uniqueness: true

	scope :actives, -> { where(active: true) }
	
	def used
		!self.tickets.where(used: :true).empty?
	end

	def is_completed?
		self.tickets.where(used: :false).empty?
	end

	def create_ticket_book number_from, number_until
		ActiveRecord::Base.transaction do
			if number_from >= number_until
				errors.add(:base, 'El numero de inicio debe ser menor al de fin')
			end
			self.save
			for n in number_from..number_until do
				self.tickets.create( number: n )
			end
		end
	end

	def check_is_completed
		self.update(completed: true) if self.is_completed?
	end
end
