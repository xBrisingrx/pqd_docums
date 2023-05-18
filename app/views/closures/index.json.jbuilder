json.data @closures do |closure|
	json.start_end_date "#{date_format(closure.start_date)} - #{date_format(closure.end_date)}"
	json.tickets closure.tickets.count
	json.actions "#{link_to "<i class='fa fa-file-excel-o'></i>".html_safe, by_closure_reports_path(format: :xlsx, closure_id: closure.id ), 
                class: 'btn u-btn-outline-teal u-btn-hover-v1-2 mb-2 mr-4',
                title: 'Reporte de las cargas'}
                #{link_to "<i class='fa fa-eye'></i>".html_safe, 
                	show_tickets_closures_path(closure_id: closure.id ), 
                	class: 'btn u-btn-outline-blue u-btn-hover-v1-2 mb-2 mr-4',
                	remote: true,
                	title: 'Ver tickets'}"
end
