# == Schema Information
#
# Table name: closures
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  start_date :date             not null
#  end_date   :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  was_send   :boolean          default(FALSE)
#
class Closure < ApplicationRecord
	has_many :closure_tickets
	has_many :tickets, through: :closure_tickets
	validates :start_date, :end_date, presence: true
	validate :end_date_after_start_date
	validate :start_date_after_last_closure

	# before_create :tickets_are_found
	# after_create :associate_tickets

	def self.last_date
		order(end_date: :desc).first.end_date
	end

	private 

	def start_date_after_last_closure
		closure = Closure.where( "start_date BETWEEN ? AND ?", self.start_date, self.end_date ).or(Closure.where("end_date BETWEEN ? AND ?", self.start_date, self.end_date))
		if !closure.empty?
			errors.add(:start_date, "Ya se hizo un cierre en estas fechas.")
			errors.add(:end_date, "Ya se hizo un cierre en estas fechas.")
		end
	end

	def end_date_after_start_date
		if self.end_date <= self.start_date
			errors.add(:end_date, "Debe ser mayor a la fecha desde.")
		end
	end

	# def tickets_are_found
	# 	fuel_loads = FuelToVehicle.where( "computable_date BETWEEN ? AND ?", self.start_date, self.end_date )
	# 	if fuel_loads.empty?
	# 		errors.add(:start_date, "No hay tickets registrados en estas fechas.")
	# 		errors.add(:end_date, "No hay tickets registrados en estas fechas.")
	# 	end
	# end

	# def associate_tickets
	# 	fuel_loads = FuelToVehicle.where( "computable_date BETWEEN ? AND ?", self.start_date, self.end_date )
	# 	raise ActiveRecord::RecordInvalid.new(self) if fuel_loads.empty?

	# 	fuel_loads.each do |fuel_load|
	# 		if !fuel_load.ticket.closed
	# 			errors.add(:end_date, "")
	# 			errors.add(:end_date, "No se pueden asignar los tickets.")
	# 			ActiveRecord::RecordInvalid.new(self)
	# 		end

	# 		ClosureTicket.create( closure: self, ticket: fuel_load.ticket )
	# 		fuel_load.ticket.update(closed: true)
	# 	end 
	# end
end
