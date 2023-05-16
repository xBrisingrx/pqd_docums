json.data @closures do |closure|
	json.start_end_date "#{date_format(closure.start_date)} - #{date_format(closure.end_date)}"
	json.tickets closure.tickets.count
	json.actions ""
end
