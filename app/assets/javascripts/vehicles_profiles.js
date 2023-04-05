let vehicles_profiles_table

$(document).ready(function(){
	vehicles_profiles_table = $("#vehicles_profiles_table").DataTable({
    'ajax': 'vehicles_profiles',
    'columns': [
    {'data': 'code'},
    {'data': 'domain'},
    {'data': 'profile'},
    {'data': 'start_date'},
    {'data': 'end_date'},
    {'data': 'status'},
    {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
	})
})