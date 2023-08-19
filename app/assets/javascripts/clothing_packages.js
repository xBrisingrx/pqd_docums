let clothing_packages_table

let clothing_package = {
  add_clothe: () => {
    let clothe_selected = $("#clothing_package_clothe_id option:selected")
    const clothe_id = clothe_selected.val()
    // verifico que en el edit no meta ropa repetida
    if (document.querySelector(`#clothes_pack_${clothe_id}`) != null) {
      noty_alert('info', 'Este pack ya tiene esta prenda')
      // return
    }

    if (clothe_id != '' ) {
      document.getElementById('list_clothes').innerHTML += `
          <tr class='clothes_body'>
            <td id='td_clothe_id' data-value=${clothe_id}>${clothe_selected.text()}</td>
            <td> <button class='btn btn-xs u-btn-red' onclick='clothing_package.remove_clothe(${clothe_id})'> <i class='fa fa-trash'> </i></button> </td>
          </tr>
        `
    }
    $('#clothing_package_clothe_id option:selected').attr('disabled', 'disabled')
    $('.select-clothe').val('').trigger('change')
  },
  remove_clothe: (id) => {
    event.preventDefault()
    let element = event.target.parentElement.parentElement
    element.remove()
    $(`#clothing_package_clothe_id option[value='${id}']`).attr('disabled', false)
  },
  set_expiration_days: () => {
    let expiration_type = document.getElementById('clothing_package_expiration_type')
    let days = expiration_type.options[expiration_type.selectedIndex].dataset.days
    if (days == 0) {
      document.getElementById('clothing_package_days_of_validity').value = ''
      document.getElementById('clothing_package_days_of_validity').parentNode.parentNode.style.display = ''
    } else {
      document.getElementById('clothing_package_days_of_validity').parentNode.parentNode.style.display = 'none'
      document.getElementById('clothing_package_days_of_validity').value = days
    }
  },
  submit: (form_url, form_method) => {
    let form = new FormData()
    let clothes_list = document.getElementsByClassName('clothes_body')
    let clothe_index = 1
    form.append( `clothing_package[name]`, document.querySelector('#clothing_package_name').value )
    form.append( `clothing_package[description]`, document.querySelector('#clothing_package_description').value )
    form.append( `clothing_package[days_of_validity]`, document.querySelector('#clothing_package_days_of_validity').value )
    for (let data of clothes_list) {
      form.append( `clothing_package[clothes_packs_attributes][${clothe_index}][clothe_id]`, data.querySelector('#td_clothe_id').dataset.value )
      clothe_index++
    }
    fetch( form_url , {
        method: form_method,
        headers: {           
          'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
        },
        body: form
      })
      .then( response => response.json() )
      .then( response => {
        if (response.status === 'success') {
          noty_alert(response.status, response.msg)
          clothing_packages_table.ajax.reload(null,false)
          $("#modal").modal('hide')
        }
      } )
      .catch( error => noty_alert('error', 'Ocurrio un error') )
    },
}

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
