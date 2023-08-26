json.data @clothing_packages do |clothing_package|
	json.name clothing_package.name
	json.description clothing_package.description
	clothes = ""
	clothing_package.clothes.map{ |c| clothes += "<li>#{c.name}</li>" }
	json.clothes clothes
	if clothing_package.one_clothes?
		json.actions " <button class='btn btn-sm u-btn-red text-white' title='Eliminar' 
  								onclick='modal_disable_clothing_package( #{ clothing_package.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
	else 
		json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_clothing_package_path(clothing_package), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_clothing_package( #{ clothing_package.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
	end
end
