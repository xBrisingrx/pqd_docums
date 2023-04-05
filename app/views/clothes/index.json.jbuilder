json.data @clothes do |clothe|
	json.name clothe.name
	json.description clothe.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_clothe_path(clothe), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_clothe( #{ clothe.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
