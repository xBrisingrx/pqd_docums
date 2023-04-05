let companies_table,companies_type

function modal_disable_company(id) {
  $('#modal-disable-company #company_id').val(id)
  $('#modal-disable-company').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('companies_d_type') != undefined ) {
    companies_type = document.getElementById('companies_d_type').value
  }
	companies_table = $("#companies_table").DataTable({
    'ajax': `companies?d_type=${companies_type}`,
    'columns': [
    {'data': 'name'},
    {'data': 'description'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-company").on("ajax:success", function(event) {
    companies_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-company").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-company #company_${key}`).addClass('is-invalid')
      $(`#form-company .company_${key}`).text( value ).show('slow')
    })
  })
})

