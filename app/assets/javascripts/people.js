let form_person, people_table, inactive_people_table

function modal_disable_person(id) {
  clean_form('form-disable-person')
  setInputDate('#form-disable-person #date')
  $('.select-2-reasons').val(''); // Select the option with a value of '1'
  $('.select-2-reasons').trigger('change'); // Notify any JS components that the value changed
  $('#modal-disable-person #person_id').val(id)
  $('#modal-disable-person').modal('show')
}

$(document).ready(function(){
  people_table = $("#people_table").DataTable({
    'ajax': 'people',
    'columns': [
    {'data': 'file'},
    {'data': 'last_name'},
    {'data': 'name'},
    {'data': 'dni'},
    {'data': 'tramit_number'},
    {'data': 'dni_file'},
    {'data': 'cuil'},
    {'data': 'cuil_file'},
    {'data': 'birth_date'},
    {'data': 'start_activity'},
    {'data': 'start_activity_file'},
    {'data': 'direction'},
    {'data': 'phone'},
    {'data': 'nationality'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  inactive_people_table = $("#inactive_people_table").DataTable({
    'ajax': 'inactive_people',
    'columns': [
    {'data': 'file'},
    {'data': 'name'},
    {'data': 'dni'},
    {'data': 'reason'},
    {'data': 'date'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $('.select-2-reasons').select2({ width: '50%',theme: "bootstrap4", placeholder: "Seleccione motivo (*)" })

  $("#form-disable-person").on("ajax:success", function(event) {
    people_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-person").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-person #person_${key}`).addClass('is-invalid')
      $(`#form-person .person_${key}`).text( value ).show('slow')
    })
  })

})