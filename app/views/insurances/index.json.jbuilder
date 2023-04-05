json.data @insurances do |insurance|
	json.name insurance.name
	json.description insurance.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_insurance_path(insurance), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_insurance( #{ insurance.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
