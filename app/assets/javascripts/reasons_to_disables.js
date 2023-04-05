let reasons_table
let reasons_type = ''
function modal_disable_reason(id) {
  $('#modal-disable-reason #reason_id').val(id)
  $('#modal-disable-reason').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('d_type') != undefined ) {
    reasons_type = document.getElementById('d_type').value
  }
	reasons_table = $("#reasons_table").DataTable({
    'ajax': `reasons_to_disables?d_type=${reasons_type}`,
    'columns': [
    {'data': 'reason'},
    {'data': 'description'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-reason").on("ajax:success", function(event) {
    reasons_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-reason").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    $.each( msg, function( key, value ) {
      $('#form-disable-reason #end_date').addClass('is-invalid')
      $('#form-disable-reason .end_date').text( value ).show('slow')
    })
  })
})

