json.data @fuel_suppliers do |fuel_supplier|
	json.name fuel_supplier.name
	json.supplier_type fuel_supplier.name_supplier_type
	json.fuel_load fuel_supplier.fuel_load
	json.description fuel_supplier.description
	if fuel_supplier.supplier?
		json.actions "#{ link_to '<i class="fa fa-plus"></i>'.html_safe, new_fuel_load_path(fuel_supplier_id: fuel_supplier.id), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Registar carga de combustible' } 
	#{ link_to '<i class="fa fa-eye"></i>'.html_safe, fuel_load_path(fuel_supplier.id), remote: :true, class: 'btn btn-sm u-btn-cyan text-white', title: 'Ver cargas' } "
	else
		json.actions ''
	end
end
