json.data @people_profiles do |person_profile|
    if person_profile.profile.active
      json.name person_profile.assignated.name
      json.last_name person_profile.assignated.last_name
      json.dni person_profile.assignated.dni
      json.profile person_profile.profile.name
      json.start_date date_format(person_profile.start_date)
      json.end_date date_format(person_profile.end_date)
      json.status status_format( person_profile.active )
      
      if person_profile.active
        json.actions "#{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
                          edit_people_profile_path(person_profile), data: {toggle: 'tooltip'}, remote: :true, 
                          class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
      else 
        json.actions "#{ link_to '<i class="fa fa-retweet"></i>'.html_safe, 
                          edit_people_profile_path(person_profile), data: {toggle: 'tooltip'}, remote: :true, 
                          class: 'btn btn-sm u-btn-teal text-white', title: 'Reactivar' }"
      end
    end

end