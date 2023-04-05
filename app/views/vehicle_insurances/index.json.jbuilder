json.data @vehicle_insurances do |vehicle_insurance|
	json.insurance vehicle_insurance.insurance.name 
	json.policy vehicle_insurance.policy
	json.start_date date_format(vehicle_insurance.start_date)
	json.end_date date_format(vehicle_insurance.end_date)
	json.file show_vehicle_insurances_files(vehicle_insurance)
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe,edit_vehicle_insurance_path(vehicle_insurance), class: 'btn u-btn-orange btn-sm', remote: true}
								<a class='btn u-btn-red btn-sm text-white' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_renovation( #{ vehicle_insurance.id } )'>
                    <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end