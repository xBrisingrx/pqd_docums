json.data @vehicles_profiles do |vehicle_profile|
    if vehicle_profile.profile.active
      json.code vehicle_profile.assignated.code
      json.domain vehicle_profile.assignated.domain
      json.profile vehicle_profile.profile.name
      json.start_date date_format(vehicle_profile.start_date)
      json.end_date date_format(vehicle_profile.end_date)
      json.status status_format( vehicle_profile.active )
      
      if vehicle_profile.active
        json.actions "#{ link_to '<i class="fa fa-trash"></i>'.html_safe, 
                          edit_vehicles_profile_path(vehicle_profile), data: {toggle: 'tooltip'}, remote: :true, 
                          class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
      else 
        json.actions "#{ link_to '<i class="fa fa-retweet"></i>'.html_safe, 
                          edit_vehicles_profile_path(vehicle_profile), data: {toggle: 'tooltip'}, remote: :true, 
                          class: 'btn btn-sm u-btn-teal text-white', title: 'Reactivar' }"
      end
    end

end