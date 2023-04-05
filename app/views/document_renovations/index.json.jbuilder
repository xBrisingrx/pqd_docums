json.data @document_renovations do |renovation|
	json.renovation_date date_format(renovation.renovation_date)
	json.expiration_date date_format(renovation.expiration_date)
	json.file show_files(renovation)
	json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe,edit_document_renovation_path(renovation), class: 'btn u-btn-orange btn-sm', remote: true}
								<a class='btn u-btn-red btn-sm text-white' data-toggle='tooltip' title='Dar de baja' onclick='modal_disable_renovation( #{ renovation.id } )'>
                    <i class='fa fa-trash' aria-hidden='true'></i> </a>"
end