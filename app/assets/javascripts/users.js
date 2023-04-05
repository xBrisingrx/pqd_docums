let users_table,users_type

function modal_disable_user(id) {
  $('#modal-disable-user #user_id').val(id)
  $('#modal-disable-user').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('users_d_type') != undefined ) {
    users_type = document.getElementById('users_d_type').value
  }
	users_table = $("#users_table").DataTable({
    'ajax': `users`,
    'columns': [
    {'data': 'name'},
    {'data': 'email'},
    {'data': 'username'},
    {'data': 'rol'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-user").on("ajax:success", function(event) {
    users_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-user").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    $.each( msg, function( key, value ) {
      $(`#form-user #user_${key}`).addClass('is-invalid')
      $(`#form-user .user_${key}`).text( value ).show('slow')
    })
  })
})

