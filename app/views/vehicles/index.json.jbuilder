json.data @vehicles do |vehicle|
	json.code vehicle.code
	json.domain vehicle.domain 
	json.year vehicle.year 
	json.brand vehicle.brand 
	json.model vehicle.vehicle_model.name
	json.type vehicle.vehicle_type.name
	json.chassis vehicle.chassis   
	json.engine vehicle.engine 
	json.seats vehicle.seats 
	json.observations vehicle.observations 
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_vehicle_path(vehicle), 
                  class: 'btn btn-warning btn-sm',  data: {toggle: 'tooltip'}, title: 'Editar', remote: true }
                  <a class='btn btn-danger btn-sm' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_vehicle( #{ vehicle.id } )'>
                    <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end