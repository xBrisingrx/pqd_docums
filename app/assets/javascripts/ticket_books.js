let ticket_books_table

function modal_disable_ticket_book(id) {
  $('#modal-disable-ticket-book #ticket_book_id').val(id)
  $('#modal-disable-ticket-book').modal('show')
}

// $(document).ready(function(){
// 	ticket_books_table = $("#ticket_books_table").DataTable({
//     'ajax': `ticket_books`,
//     'columns': [
//     {'data': 'name'},
//     {'data': 'ticket_range'},
//     {'data': 'used'},
//     {'data': 'completed'},
//     {'data': 'actions'}
//     ],
//     'language': {'url': datatables_lang}
// 	})


// })
