let clothing_packages_table

function modal_disable_clothing_package(id) {
  $('#modal-disable-clothing-package #clothing_package_id').val(id)
  $('#modal-disable-clothing-package').modal('show')
}

$(document).ready(function(){
	clothing_packages_table = $("#clothing_packages_table").DataTable({
    'ajax': `clothing_packages`,
    'columns': [
    {'data': 'name'},
    {'data': 'description'},
    {'data': 'clothes'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-clothing-package").on("ajax:success", function(event) {
    clothing_packages_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-clothing-package").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-clothing-package #clothing_package_${key}`).addClass('is-invalid')
      $(`#form-clothing-package .clothing_package_${key}`).text( value ).show('slow')
    })
  })
})
