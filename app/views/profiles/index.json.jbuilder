json.data @profiles do |profile|
	json.profile profile.name
	json.start_date date_format(profile.start_date)
	json.end_date date_format(profile.end_date)
	json.status status_format(profile.active)
	json.description profile.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_profile_path(id: profile.id, d_type: params[:d_type]), remote: :true, class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
								<button class='btn btn-sm u-btn-red text-white' 
  								title='Eliminar' 
  								onclick='modal_disable_profile( #{ profile.id } )'>
									<i class='fa fa-trash-o' aria-hidden='true'></i></button> "
end


