let insurances_table,insurances_type

function modal_disable_insurance(id) {
  $('#modal-disable-insurance #insurance_id').val(id)
  $('#modal-disable-insurance').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('insurances_d_type') != undefined ) {
    insurances_type = document.getElementById('insurances_d_type').value
  }
	insurances_table = $("#insurances_table").DataTable({
    'ajax': `insurances`,
    'columns': [
    {'data': 'name'},
    {'data': 'description'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-insurance").on("ajax:success", function(event) {
    insurances_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-insurance").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-insurance #insurance_${key}`).addClass('is-invalid')
      $(`#form-insurance .insurance_${key}`).text( value ).show('slow')
    })
  })
})

