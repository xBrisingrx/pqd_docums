let ticket_books_table

function modal_disable_ticket_book(id) {
  $('#modal-disable-ticket_book #ticket_book_id').val(id)
  $('#modal-disable-ticket_book').modal('show')
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

//   $("#form-disable-ticket-book").on("ajax:success", function(event) {
//     ticket_books_table.ajax.reload(null,false)
//     let msj = JSON.parse(event.detail[2].response)
//     noty_alert(msj.status, msj.msg)
//     $("#modal-disable-ticket-book").modal('hide')
//   }).on("ajax:error", function(event) {
//     let msj = JSON.parse( event.detail[2].response )
//     $.each( msj, function( key, value ) {
//       $(`#form-ticket-book #ticket_book_${key}`).addClass('is-invalid')
//       $(`#form-ticket-book .ticket_book_${key}`).text( value ).show('slow')
//     })
//   })
// })
