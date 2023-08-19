json.data @vehicle_brands do |vehicle_brand|
	json.name vehicle_brand.name
	json.actions "<a class='btn btn-danger btn-sm' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_vehicle_brand( #{ vehicle_brand.id } )'>
                  <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end