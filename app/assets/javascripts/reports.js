// let select_multiple_vehicle_documents
// select_multiple_vehicle_documents = $('.select_multiple_vehicle_documents').select2({
//       theme: 'bootstrap4',
//       width: '90%'
//   })


$( document ).ready(function() {
	 $('.select_multiple_vehicle_documents').select2({
      theme: 'bootstrap4',
      width: '90%'
  })

	// $("#vehicle-report-between-dates").on("ajax:success", function(event) {
	//     const link = document.createElement('a')
	//     const blob = new Blob( [event.detail[2].response], {type: 'text/xlsx' })
	//     link.href = window.URL.createObjectURL(blob)
	//     link.download = 'reporte.xlsx'
	//     link.click()

	//   }).on("ajax:error", function(event) {
	// 	let msg = JSON.parse( event.detail[2].response )
	// 	set_input_status_form('form-person', 'person', msg)
	// })
})

let report_between_dates = (url, filename) => {
	event.preventDefault()
	const form = new FormData()
	const report_form = document.getElementById('report-between-dates')
	form.append( 'start_date', report_form.querySelector( '#start_date' ).value )
	form.append( 'end_date', report_form.querySelector( '#end_date' ).value )

	let selected = [];
  for (let option of report_form.querySelector( '#document_id' ).options)
  {
      if (option.selected) {
          selected.push(option.value);
      }
  }
  form.append( 'document_ids[]', selected )
  
  fetch(url, {
  	method: 'POST',
  	headers: {       
      'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
    },
    body: form
  })
  .then( response => response.blob() )
  .then( file => {
  	const a = document.createElement("a");
  	a.href = window.URL.createObjectURL(file);
  	a.download = filename;
  	a.click();
  } )
}