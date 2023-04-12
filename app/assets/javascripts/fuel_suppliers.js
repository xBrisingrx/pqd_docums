let fuel_suppliers_table,fuel_suppliers_type

function modal_disable_fuel_supplier(id) {
  $('#modal-disable-fuel_supplier #fuel_supplier_id').val(id)
  $('#modal-disable-fuel_supplier').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('fuel_suppliers_d_type') != undefined ) {
    fuel_suppliers_type = document.getElementById('fuel_suppliers_d_type').value
  }
	fuel_suppliers_table = $("#fuel_suppliers_table").DataTable({
    'ajax': `fuel_suppliers`,
    'columns': [
    {'data': 'name'},
    {'data': 'supplier_type'},
    {'data': 'fuel_load'},
    {'data': 'description'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-fuel-supplier").on("ajax:success", function(event) {
    fuel_suppliers_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-fuel_supplier").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-fuel-supplier #fuel_supplier_${key}`).addClass('is-invalid')
      $(`#form-fuel-supplier .fuel_supplier_${key}`).text( value ).show('slow')
    })
  })
})

