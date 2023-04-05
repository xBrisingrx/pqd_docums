json.data @people_clothes do |person_clothe|
	json.pack person_clothe.clothing_package.name
	json.start_date date_format(person_clothe.start_date)
	json.end_date date_format(person_clothe.end_date)
	json.description person_clothe.description
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe,edit_people_clothe_path(person_clothe), class: 'btn u-btn-orange btn-sm', remote: true}
								<a class='btn u-btn-red btn-sm text-white' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_person_clothe( #{ person_clothe.id } )'>
                    <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end