module DocumentRenovationsHelper
	
	def show_files renovation 
		pdf_button = ''
		if renovation.files.attached? 
			if renovation.files.count == 1
				pdf_button = "#{ link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, renovation.files.first, target: '_blank' }"
			else
				pdf_button = "#{ link_to '<i class="fa fa-file-pdf-o fa-2x"></i>'.html_safe, 
							document_renovation_show_files_path( document_renovation_id: renovation.id), remote: true }"
			end
		else
			pdf_button = "<p><i class='fa fa-file-pdf-o fa-2x'></i></p>"
		end
		
		pdf_button
	end

end