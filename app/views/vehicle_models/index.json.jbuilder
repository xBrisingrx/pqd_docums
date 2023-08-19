json.data @vehicle_models do |vehicle_model|
	json.name vehicle_model.name
	json.brand vehicle_model.vehicle_brand.name
	json.actions "<a class='btn btn-danger btn-sm text-white' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_vehicle_model( #{ vehicle_model.id } )'>
                  <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end