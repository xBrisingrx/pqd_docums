let clothes_table

function modal_disable_clothe(id) {
  $('#modal-disable-clothe #clothe_id').val(id)
  $('#modal-disable-clothe').modal('show')
}

$(document).ready(function(){
	clothes_table = $("#clothes_table").DataTable({
    'ajax': `clothes`,
    'columns': [
    {'data': 'name'},
    {'data': 'description'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-clothe").on("ajax:success", function(event) {
    clothes_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-clothe").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-clothe #clothe_${key}`).addClass('is-invalid')
      $(`#form-clothe .clothe_${key}`).text( value ).show('slow')
    })
  })
})
