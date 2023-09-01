let document_renovations_table,dr

const document_renovation = {
	send_renovation_data(asignated_document_id, document_expire, form_method){
	  event.preventDefault()
	  form = document.getElementById(event.target.parentElement.parentElement.id)
	  if (document_expire && form.querySelector('#document_renovation_renovation_date').value == '') {
	    form.querySelector('#document_renovation_renovation_date').parentElement.classList.add('u-has-error-v1')
	    form.querySelector('#error_renovation_date').innerHTML = 'Debe ingresar una fecha'
	    return
	  } else {
	    form.querySelector('#document_renovation_renovation_date').parentElement.classList.remove('u-has-error-v1')
	    form.querySelector('#error_renovation_date').innerHTML = ''
	  }

	  if (document_expire && form.querySelector('#document_renovation_expiration_date').value == '') {
	    form.querySelector('#document_renovation_expiration_date').parentElement.classList.add('u-has-error-v1')
	    form.querySelector('#error_expiration_date').innerHTML = 'Debe ingresar una fecha'
	    return
	  } else {
	    form.querySelector('#document_renovation_expiration_date').parentElement.classList.remove('u-has-error-v1')
	    form.querySelector('#error_expiration_date').innerHTML = ''
	  }

	  if ( !document_expire && form.querySelector('#document_renovation_file').value == '' ) {
	    form.querySelector('#document_renovation_file').parentElement.classList.add('u-has-error-v1')
	    form.querySelector('.error_renovation_file').innerHTML = 'Debe ingresar un documento'
	    return
	  } else {
	    form.querySelector('#document_renovation_file').parentElement.classList.remove('u-has-error-v1')
	    form.querySelector('.error_renovation_file').innerHTML = ''
	  }

	  this.renovation_submit(asignated_document_id, form,form_method)
	},
	renovation_submit(asignated_document_id, form, form_method){
	  let formData = new FormData()
	  formData.append('document_renovation[assignments_document_id]', asignated_document_id )
	  formData.append('document_renovation[renovation_date]', form.querySelector('#document_renovation_renovation_date').value )
	  formData.append('document_renovation[expiration_date]', form.querySelector('#document_renovation_expiration_date').value )
	  let files = form.querySelector('#document_renovation_file')
	  if (files !== null) {
	    let totalFiles = files.files.length
	    if (totalFiles > 0) {
	      for (let n = 0; n < totalFiles; n++) {
	        formData.append(`document_renovation[files][]`, files.files[n])
	      }
	    }
	  }
	  fetch(form.action, {
	      method: form_method,
	      headers: {           
	        'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
	      },
	      body: formData
	    }
	  )
	  .then( response => response.json() )
	  .then( response => {
	    if (response.status === 'success') {
	      $("#modal_edit_renovation").modal('hide')
	      clean_form(form.id)
	      document_renovations_table.ajax.reload(null,false)
	      assignments_assigned_documents.ajax.reload(null,false)
	      noty_alert(response.status, response.msg)
	    } else {
	      Object.entries(response.msg).forEach(([key, value]) => {
	        form.querySelector(`#error_${key}`).parentElement.classList.add('u-has-error-v1')
	        form.querySelector(`#error_${key}`).innerHTML = value[0]
	      })
	    }
	  } )
	  .catch( error => {
	    noty_alert('error', error)
	    console.log(error)
	  } )
	}
}

function modal_disable_renovation(id) {
  clean_form('form-disable-renovation')
  $('#modal-disable-renovation #document_renovation_id').val(id)
  $('#modal-disable-renovation').modal('show')
}

$(document).ready(function(){
	$("#form-disable-renovation").on("ajax:success", function(event) {
	  document_renovations_table.ajax.reload(null,false)
	  assignments_assigned_documents.ajax.reload(null,false)
	  let msg = JSON.parse(event.detail[2].response)
	  noty_alert(msg.status, msg.msg)
	  $('#modal-disable-renovation').modal('hide')
	}).on("ajax:error", function(event) {
	  let msg = JSON.parse( event.detail[2].response )
	  $.each( msg, function( key, value ) {
	    $(`#form-disable-renovation #renovation_${key}`).addClass('is-invalid')
	    $(`#form-disable-renovation .renovation_${key}`).text( value ).show('slow')
	  })
	})
})