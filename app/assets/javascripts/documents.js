let documents_table
let documents_type = ''

const documents = {
  check_is_expire: (checkbox) => {
    if (checkbox.checked) {
      document.getElementById('document_expiration_type_id').parentNode.parentNode.style.display = ''
      document.getElementById('document_allow_modify_expiration').parentNode.parentNode.style.display = ''
    } else {
      document.getElementById('document_expiration_type_id').parentNode.parentNode.style.display = 'none'
      document.getElementById('document_allow_modify_expiration').parentNode.parentNode.style.display = 'none'
      document.getElementById('document_allow_modify_expiration').value = ''
    }
  }
}

function modal_disable_document(id) {
  $('#modal-disable-document #document_id').val(id)
  setInputDate('#form-disable-document #end_date')
  $('#form-disable-document #end_date').removeClass('is-invalid')
  $('#form-disable-document .end_date').text('')
  $('#modal-disable-document').modal('show')
}

$(document).ready(function(){
  if ( document.getElementById('d_type') != undefined ) {
    documents_type = document.getElementById('d_type').value
  }
	documents_table = $("#documents_table").DataTable({
    'ajax': `documents?d_type=${documents_type}`,
    'columns': [
    {'data': 'name'},
    {'data': 'description'},
    {'data': 'category'},
    {'data': 'expires'},
    {'data': 'expiration_type'},
    {'data': 'days_of_validity'},
    {'data': 'allow_modify_expiration'},
    {'data': 'observations'},
    {'data': 'renewal_methodology'},
    {'data': 'monthly_summary'},
    {'data': 'start_date'},
    {'data': 'end_date'},
    {'data': 'apply_all'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})

  $("#form-disable-document").on("ajax:success", function(event) {
    documents_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-document").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    $.each( msg, function( key, value ) {
      $('#form-disable-document #end_date').addClass('is-invalid')
      $('#form-disable-document .end_date').text( value ).show('slow')
    })
  })
})

