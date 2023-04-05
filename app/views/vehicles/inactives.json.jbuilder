json.data @vehicles do |vehicle|
	json.code vehicle.code
	json.domain vehicle.domain 
	json.year vehicle.year 
	json.reason vehicle.activity_histories.last.reasons_to_disable.reason 
	json.date date_format(vehicle.activity_histories.last.date)
	json.actions "#{ link_to '<i class="fa fa-eye"></i>'.html_safe, show_vehicle_history_path(id: vehicle.id), 
                  class: 'btn u-btn-blue btn-sm',  data: {toggle: 'tooltip'}, title: 'Ver historial', remote: true }  	
                #{ link_to '<i class="fa fa-refresh"></i>'.html_safe, modal_enable_vehicle_path(id: vehicle.id), 
                  class: 'btn u-btn-orange btn-sm',  data: {toggle: 'tooltip'}, title: 'Reactivar', remote: true }"
end