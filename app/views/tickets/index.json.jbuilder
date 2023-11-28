json.data @tickets do |ticket|
	json.number ticket.number
	json.used ( ticket.used ) ? 'Si' : 'No'
	if ticket.active
		json.status "
			<span class='u-label g-rounded-3 g-bg-blue g-mr-10 g-mb-15'>
			  <i class='fa fa-bookmark g-mr-3'></i>
			  Sunt at vero et eos
			</span>
		"
	else
		json.status "
			<span class='u-label g-rounded-3 g-bg-purple g-mr-10 g-mb-15'>
			  <i class='fa fa-telegram g-mr-3'></i>
			  Dolor sit
			</span>
		"
	end
	if !ticket.used && !ticket.closed && !ticket.active
		json.actions "#{link_to '<i class="fa fa-trash"></i>'.html_safe, 
	                  modal_change_status_ticket_path( ticket ), 
	                  remote: true, class: 'text-center text-danger', title: 'Anular ticket' } "
	else
		json.actions ""
	end
	
end


 