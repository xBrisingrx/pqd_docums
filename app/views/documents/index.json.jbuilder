json.data @documents do |document|
    json.name document.name
    json.description document.description
    json.category document.document_category.name
    json.expires ( document.expires ) ? 'Si' : 'No'
    json.expiration_type ( document.expires ) ? document.expiration_type.name : ''
    json.days_of_validity ( document.expires ) ? document.days_of_validity : "<h4>∞</h4>"
    json.allow_modify_expiration  ( document.allow_modify_expiration ) ? 'Si' : 'No'
    json.observations document.observations
    json.renewal_methodology document.renewal_methodology
    json.monthly_summary ( document.monthly_summary ) ? 'Si' : 'No'
    json.start_date date_format(document.start_date)
    json.end_date date_format(document.end_date)
    json.apply_all '-'
    json.status status_format( document.active )
    if document.active
      json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_document_path(document), data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' } 
                        <button class='btn btn-sm u-btn-red text-white' 
                        data-toggle='tooltip'
                        title='Eliminar'
                        onclick='modal_disable_document( #{ document.id } )'>
                        <i class='fa fa-trash-o' aria-hidden='true'></i></button> "
    else 
      json.actions "<button class='btn btn-sm u-btn-orange text-white' 
                      data-toggle='tooltip'
                      title='Reactivar'
                      onclick=''> <i class='fa fa-refresh' aria-hidden='true'></i></button>"
    end
end