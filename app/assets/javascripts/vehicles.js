let form_vehicle, vehicles_table, inactive_vehicles_table

function modal_disable_vehicle(id) {
  clean_form('form-disable-vehicle')
  setInputDate('#form-disable-vehicle #date')
  $('.select-2-reasons').val(''); // Select the option with a value of '1'
  $('.select-2-reasons').trigger('change'); // Notify any JS components that the value changed
  $('#modal-disable-vehicle #vehicle_id').val(id)
  $('#modal-disable-vehicle').modal('show')
}

$(document).ready(function(){
  vehicles_table = $("#vehicles_table").DataTable({
    'ajax': 'vehicles',
    'columns': [
    {'data': 'code'},
    {'data': 'domain'},
    {'data': 'year'},
    {'data': 'brand'},
    {'data': 'model'},
    {'data': 'type'},
    {'data': 'chassis'},
    {'data': 'engine'},
    {'data': 'observations'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  inactive_vehicles_table = $("#inactive_vehicles_table").DataTable({
    'ajax': 'inactives_vehicles',
    'columns': [
    {'data': 'code'},
    {'data': 'domain'},
    {'data': 'year'},
    {'data': 'reason'},
    {'data': 'date'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $('.select-2-reasons').select2({ width: '50%',theme: "bootstrap4", placeholder: "Seleccione motivo (*)" })

  $("#form-disable-vehicle").on("ajax:success", function(event) {
    vehicles_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-vehicle").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-vehicle #vehicle_${key}`).addClass('is-invalid')
      $(`#form-vehicle .vehicle_${key}`).text( value ).show('slow')
    })
  })

})