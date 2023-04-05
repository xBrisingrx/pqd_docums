json.data @documents_profiles do |document_profile|
    json.profile document_profile.profile.name
    json.document document_profile.document.name
    json.start_date date_format(document_profile.start_date)
    json.end_date date_format(document_profile.end_date)
    json.status status_format( document_profile.active )

    if document_profile.active
      json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_documents_profile_path(document_profile), data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' }
                    #{ link_to '<i class="fa fa-trash-o"></i>'.html_safe, modal_disable_document_profile_path(document_profile), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
    else 
      json.actions "<button class='btn btn-sm u-btn-orange text-white' 
                      data-toggle='tooltip'
                      title='Reactivar'
                      onclick=''> <i class='fa fa-refresh' aria-hidden='true'></i></button>"
    end
end