let documents_profiles_table
let documents_profiles_type = ''


$(document).ready(function(){
  if ( document.getElementById('d_type') != undefined ) {
    documents_profiles_type = document.getElementById('d_type').value
  }
	documents_profiles_table = $("#documents_profiles_table").DataTable({
    'ajax': `documents_profiles?d_type=${documents_profiles_type}`,
    'columns': [
    {'data': 'profile'},
    {'data': 'document'},
    {'data': 'start_date'},
    {'data': 'end_date'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})
})