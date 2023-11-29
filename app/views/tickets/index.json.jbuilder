json.data @tickets do |ticket|
	json.number ticket.number
	json.used ( ticket.used ) ? 'Si' : 'No'
	if ticket.active && ticket.used
		json.status "
			<span class='u-label g-rounded-3 g-bg-blue g-mr-10 g-mb-15'>
			  <i class='fa fa-industry g-mr-3'></i>
			  Usado
			</span>
		"
	elsif ticket.active && !ticket.used
		json.status "
			<span class='u-label g-rounded-3 g-bg-green g-mr-10 g-mb-15'>
			  <i class='fa fa-check-circle g-mr-3'></i>
			  Disponible
			</span>
		"
	elsif !ticket.active
		json.status "
			<span class='u-label g-rounded-3 g-bg-red g-mr-10 g-mb-15'>
			  <i class='fa fa-window-close g-mr-3'></i>
			  Anulado
			</span>
		"
	end
	if !ticket.used && !ticket.closed && ticket.active
		json.actions "#{link_to '<i class="fa fa-trash"></i>'.html_safe, 
	                  modal_change_status_ticket_path( ticket ), 
	                  remote: true, class: 'btn u-btn-red text-center text-white', title: 'Anular ticket' } "
	elsif !ticket.active
		json.actions "#{link_to '<i class="fa fa-eye"></i>'.html_safe, 
	                  modal_detail_disable_ticket_path( ticket ), 
	                  remote: true, class: 'btn u-btn-sm u-btn-purple text-center text-white', title: 'Ver detalle de anulacion' } "
	else
		json.actions ""
	end
end


 