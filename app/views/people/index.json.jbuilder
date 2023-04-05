json.data @people do |person|
	json.file person.file
	json.last_name person.last_name 
	json.name person.name 
	json.dni person.dni 

	if person.dni_file.attached?
		json.dni_file "#{link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, person.dni_file, target: '_blank'}"
	else
		json.dni_file "#{link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, 
                      upload_person_file_path( id: person.id, file: 'dni_file', file_name: "DNI" ), 
                      remote: true, class: 'text-center text-danger', data: {toggle: 'tooltip'}, title: 'Adjuntar archivo'}"
	end

	json.tramit_number person.tramit_number

	json.cuil person.cuil

	if person.cuil_file.attached?
		json.cuil_file "#{link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, person.cuil_file, target: '_blank'}"
	else
		json.cuil_file "#{link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, 
                      upload_person_file_path( id: person.id, file: 'cuil_file', file_name: "CUIL" ), 
                      remote: true, class: 'text-center text-danger', data: {toggle: 'tooltip'}, title: 'Adjuntar archivo'}"
	end

	json.start_activity (person.start_activity) ? date_format(person.start_activity) : ''

	if person.start_activity_file.attached?
		json.start_activity_file "#{link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, person.start_activity_file, target: '_blank'}"
	else
		json.start_activity_file "#{link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, 
                      upload_person_file_path( id: person.id, file: 'start_activity_file', file_name: "inicio actividad" ), 
                      remote: true, class: 'text-center text-danger', data: {toggle: 'tooltip'}, title: 'Adjuntar archivo'}"
	end

	json.birth_date (person.birth_date) ? date_format(person.birth_date) : ''
	json.direction person.direction 
	json.phone person.phone 
	json.nationality person.nationality
	
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_person_path(person), 
                  class: 'btn btn-warning btn-sm',  data: {toggle: 'tooltip'}, title: 'Editar', remote: true }
                  <a class='btn btn-danger btn-sm' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_person( #{ person.id } )'>
                    <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end