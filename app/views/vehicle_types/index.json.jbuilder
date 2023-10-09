json.data @vehicle_types do |vehicle_type|
	json.name vehicle_type.name
	json.actions "<a class='btn btn-danger btn-sm' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_vehicle_type( #{ vehicle_type.id } )'>
                  <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end