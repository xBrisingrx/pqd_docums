json.data @array do |document|
	json.document document[:document]
	json.category document[:category]
	json.expire document[:expire]
	json.expire_date document[:expire_date]
	
	if document[:last_renovation] && !document[:custom]
		json.file show_files(document[:last_renovation])
	elsif !document[:custom]
		json.file "<p><i class='fa fa-file-pdf-o fa-2x'></i></p>"
	end

	if document[:custom]
		json.file document[:file]	
		json.actions document[:actions]	
	end
	
	if document[:has_renovations] && !document[:custom]
		json.actions  "#{ link_to '<i class="fa fa-eye"></i>'.html_safe, document_renovations_path( assignments_document_id: document[:id] ), 
                  					class: 'btn u-btn-orange btn-sm',  
                  					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }
                  	#{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
                  		modal_disable_assignments_documents_path(id: document[:id]), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }
                  "
	elsif !document[:has_renovations] && !document[:custom]
		json.actions  "#{ link_to '<i class="fa fa-plus"></i>'.html_safe, document_renovations_path( assignments_document_id: document[:id] ), 
                  					class: 'btn u-btn-indigo btn-sm',  
                  					data: {toggle: 'tooltip'}, title: 'Ver renovaciones', remote: true }
                  #{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
                  		modal_disable_assignments_documents_path(id: document[:id]), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
	end
end