let tickets_table
let tickets = {
	changeActive: (ticket_id, ticket_active) => {
		let form = new FormData()
		form.append( 'ticket[active]', event.target.checked )
		fetch( `/tickets/${ticket_id}`, {
			method: "PATCH",
			headers: {           
        'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
      },
      body: form
		} )
		.then( response => response.json())
		.then( response => {
			if (response.status == 'error') {
				event.target.checked = !event.target.checked
			}
			noty_alert(response.status, response.msg)
		} )
	}
}