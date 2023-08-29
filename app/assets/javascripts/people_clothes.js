function modal_disable_person_clothe(id) {
  clean_form('form-disable-person-clothe')
  $('#modal-disable-person-clothe #person_clothe_id').val(id)
  $('#modal-disable-person-clothe').modal('show')
}

