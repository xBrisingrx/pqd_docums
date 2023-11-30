json.data @people do |person|
	json.name person.fullname 
	json.can_authorize "#{ form_with( url: set_permission_person_path(person), remote:true ) do |form|
		form.label :can_authorize, class: 'form-check-inline u-check g-mr-20 mx-0 mb-0' do
			form.check_box :can_authorize, checked: person.can_authorize, class: 'g-hidden-xs-up g-pos-abs g-top-0 g-right-0'
			tag.div( class: 'u-check-icon-radio-v7' ) do
				tag.i(class: 'fa', data: { 'check-icon':'', 'uncheck-icon':''})
			end
		end
	end}" 
	json.load_with_ticket "<label class='form-check-inline u-check g-mr-20 mx-0 mb-0'>
		#{check_box( :person, :load_with_ticket, {class: 'g-hidden-xs-up g-pos-abs g-top-0 g-right-0', 
			checked: person.load_with_ticket, 
			onclick: 'set_permission_person()',
			data: { 'id': person.id, 'attr': 'load_with_ticket' } } )}
    <div class='u-check-icon-radio-v7'>
      <i class='fa' data-check-icon='' data-uncheck-icon=''></i>
    </div>
  </label>"
	json.load_with_km check_box( :person, :load_with_km, {class: '', checked: person.load_with_km} )
end