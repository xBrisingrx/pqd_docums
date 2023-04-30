let fuel_vehicles_table

function modal_disable_fuel_vehicle(id) {
  $('#modal-disable-fuel-vehicle #fuel_vehicle_id').val(id)
  $('#modal-disable-fuel-vehicle').modal('show')
}

$(document).ready(function(){
  fuel_vehicles_table = $("#fuel_vehicles_table").DataTable({
    'ajax': `fuel_to_vehicles`,
    'columns': [
    {'data': 'date'},
    {'data': 'vehicle'},
    {'data': 'mileage'},
    {'data': 'fueling'},
    {'data': 'fuel_type'},
    {'data': 'supplier'},
    {'data': 'person_load'},
    {'data': 'person_authorize'},
    {'data': 'ticket'},
    {'data': 'cost_center'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-fuel-vehicle").on("ajax:success", function(event) {
    fuel_vehicles_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-fuel_vehicle").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-fuel-vehicle #fuel_vehicle_${key}`).addClass('is-invalid')
      $(`#form-fuel-vehicle .fuel_vehicle_${key}`).text( value ).show('slow')
    })
  })
})

