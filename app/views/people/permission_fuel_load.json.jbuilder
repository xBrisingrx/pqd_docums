json.data @people do |person|
	json.name person.fullname 
	json.can_authorize "<label class='form-check-inline u-check g-mr-20 mx-0 mb-0'>
		#{check_box( :person, :can_authorize, {class: 'g-hidden-xs-up g-pos-abs g-top-0 g-right-0', 
			checked: person.can_authorize, 
			onclick: 'set_permission_person()',
			data: { 'id': person.id, 'attr': 'can_authorize' } } )}
    <div class='u-check-icon-radio-v7'>
      <i class='fa' data-check-icon='' data-uncheck-icon=''></i>
    </div>
  </label>"
	json.load_with_ticket "<label class='form-check-inline u-check g-mr-20 mx-0 mb-0'>
		#{check_box( :person, :load_with_ticket, {class: 'g-hidden-xs-up g-pos-abs g-top-0 g-right-0', 
			checked: person.load_with_ticket, 
			onclick: 'set_permission_person()',
			data: { 'id': person.id, 'attr': 'load_with_ticket' } } )}
    <div class='u-check-icon-radio-v7'>
      <i class='fa' data-check-icon='' data-uncheck-icon=''></i>
    </div>
  </label>"
	json.load_with_km "<label class='form-check-inline u-check g-mr-20 mx-0 mb-0'>
		#{check_box( :person, :load_with_km, {class: 'g-hidden-xs-up g-pos-abs g-top-0 g-right-0', 
			checked: person.load_with_km, 
			onclick: 'set_permission_person()',
			data: { 'id': person.id, 'attr': 'load_with_km' } } )}
    <div class='u-check-icon-radio-v7'>
      <i class='fa' data-check-icon='' data-uncheck-icon=''></i>
    </div>
  </label>"
end


