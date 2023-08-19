	let  vehicles_models_table, select_vehicle_brands

	function modal_disable_vehicle_model(id) {
	  $('#modal-disable-vehicle-model #vehicle_model_id').val(id)
	  $('#modal-disable-vehicle-model').modal('show')
	}
