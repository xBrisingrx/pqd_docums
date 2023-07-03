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
		uniqueness: true, 
		numericality: { only_integer: true }

	after_create :verify_if_exist_closure
	after_update :check_ticket_book

	scope :unused, -> { where(used: false) }

	private
	def check_ticket_book
		self.ticket_book.check_is_completed
	end

	def verify_if_exist_closure
		# si creamos un ticket de un periodo donde no existe un cierre , hay que crear el cierre
		closure = Closure.where( 'extract(month  from start_date) = ?', self.date.month )
                         .where( 'extract(year  from start_date) = ?', self.date.year )
    if closure.blank?
    	start_date = Date.new( self.date.year, self.date.month, 26 )
      next_month = self.date.month + 1
      end_date = Date.new( self.date.year, next_month, 25 )
      Closure.create(
        start_date: start_date, 
        end_date: end_date,
        name: "Cierre periodo #{I18n.t("date.month_names")[start_date.month]} #{start_date.year}")
    end
	end
end
