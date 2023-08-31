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
	has_many :tickets, dependent: :destroy

	accepts_nested_attributes_for :tickets
	
	validates :name, 
		presence: true, 
		uniqueness: { case_sensitive: false, message: "Ya hay un talonario registrado con este nombre" }

	scope :actives, -> { where(active: true) }
	
	def used
		!self.tickets.where(used: :true).empty?
	end

	def is_completed?
		self.tickets.where(used: :false).empty?
	end

	def create_ticket_book number_from, number_until
		if number_from >= number_until
			errors.add(:base, 'El número de inicio debe ser menor al de fin')
		end
		ActiveRecord::Base.transaction do
			if !self.save
				return false
			end
			for n in number_from..number_until do
				ticket = Ticket.new( ticket_book: self, number: n )
				if !ticket.save
					errors.add(:base, 'Hay tickets que pertenecen a otro talonario')
				end
			end
		end
	end

	def check_is_completed
		if self.is_completed?
			self.update(completed: true) 
		else 
			self.update( completed: false )
		end
	end

	def set_closed
		tickets = self.tickets.where(used: false)
		tickets.destroy_all
		self.update(completed: true)
	end

	def ticket_range
		tickets = self.tickets.order(:number)
		if tickets.blank?
			"--"
		else
			"#{tickets.first.number} - #{tickets.last.number}"
		end
	end

	def disable
		tickets = self.tickets.where(used: true)
		if !tickets.blank?
			errors.add(:base, 'Hay tickets usados en este talonario') 
			return
		end
		self.destroy
	end

end
