json.data @ticket_books do |ticket_book|
	json.name ticket_book.name
	json.ticket_range ticket_book.name
	json.used ( ticket_book.used ) ? ticket_book.tickets.count : 'No'
	json.completed ( ticket_book.completed ) ? 'Completo' : 'No'
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_ticket_book_path(ticket_book), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_ticket_book( #{ ticket_book.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
