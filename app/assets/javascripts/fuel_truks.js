let fuel_truks_table

function modal_disable_fuel_truk(id) {
  $('#modal-disable-fuel_truk #fuel_truk_id').val(id)
  $('#modal-disable-fuel_truk').modal('show')
}

$(document).ready(function(){
  fuel_truks_table = $("#fuel_truks_table").DataTable({
    'ajax': `fuel_truks`,
    'columns': [
    {'data': 'name'},
    {'data': 'fuel_load'},
    {'data': 'description'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-fuel_truk").on("ajax:success", function(event) {
    fuel_truks_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-fuel_truk").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-fuel_truk #fuel_truk_${key}`).addClass('is-invalid')
      $(`#form-fuel_truk .fuel_truk_${key}`).text( value ).show('slow')
    })
  })
})

