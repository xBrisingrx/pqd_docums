json.data @reasons do |reason|
	json.reason reason.reason
	json.description reason.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_reasons_to_disable_path(reason), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_reason( #{ reason.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end
