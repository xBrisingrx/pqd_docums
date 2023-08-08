json.data @ticket_books do |ticket_book|
	json.name ticket_book.name
	json.ticket_range ticket_book.ticket_range
	json.used ( ticket_book.used ) ? 'Si' : 'No'
	json.completed ( ticket_book.completed ) ? 'Completo' : 'No'
	actions = "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_ticket_book_path(ticket_book), 
									remote: :true, class: 'btn btn-sm u-btn-primary text-white mr-2', title: 'Editar' }"
	if !ticket_book.is_completed?
		actions += "#{ link_to '<i class="fa fa fa-envelope"></i>'.html_safe, modal_closed_ticket_book_path(ticket_book), 
										remote: :true, class: 'btn btn-sm u-btn-teal text-white mr-1', title: 'Cerrar talonario' } "
	end
	actions +="<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_ticket_book( #{ ticket_book.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
	json.actions actions
end
