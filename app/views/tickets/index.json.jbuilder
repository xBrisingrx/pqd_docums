json.data @tickets do |ticket|
	json.number ticket.number
	json.used ( ticket.used ) ? 'Si' : 'No'
	if !ticket.used
		json.active "
			#{ render('tickets/form_change_active', ticket: ticket) }
		"
	else
		json.active ""
	end
	
end


 