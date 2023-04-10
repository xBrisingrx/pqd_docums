json.data @fuel_truks do |fuel_truk|
	json.name fuel_truk.name
	json.fuel_load fuel_truk.fuel_load
	json.description fuel_truk.description
	json.actions "#{ link_to '<i class="fa fa-plus"></i>'.html_safe, new_fuel_load_path(fuel_truk_id: fuel_truk.id), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Registar carga de combustible' } 
	#{ link_to '<i class="fa fa-eye"></i>'.html_safe, fuel_load_path(fuel_truk.id), remote: :true, class: 'btn btn-sm u-btn-cyan text-white', title: 'Ver cargas' } "
end
