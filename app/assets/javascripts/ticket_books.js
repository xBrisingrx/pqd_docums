let ticket_books_table

function modal_disable_ticket_book(id) {
  $('#modal-disable-ticket-book #ticket_book_id').val(id)
  $('#modal-disable-ticket-book').modal('show')
}