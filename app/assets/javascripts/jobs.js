let jobs_table
let jobs_type = ''
function modal_disable_job(id) {
  $('#modal-disable-job #job_id').val(id)
  $('#modal-disable-job').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('jobs_d_type') != undefined ) {
    jobs_type = document.getElementById('jobs_d_type').value
  }
	jobs_table = $("#jobs_table").DataTable({
    'ajax': `jobs?d_type=${jobs_type}`,
    'columns': [
    {'data': 'name'},
    {'data': 'description'},
    {'data': 'zone'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-job").on("ajax:success", function(event) {
    jobs_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-job").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    $.each( msj, function( key, value ) {
      $(`#form-disable-job #job_${key}`).addClass('is-invalid')
      $(`#form-disable-job .job_${key}`).text( value ).show('slow')
    })
  })
})

