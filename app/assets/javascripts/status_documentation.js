let assignments_assigned_profiles, assignments_assigned_documents, assignments_vehicle_profiles, assignments_vehicle_documents
const status_documentation = {
	populate_with_person_data: ()=> {
		let person_id = document.getElementById("person_select").value
		document.getElementById('assignated_id').value = person_id
		fetch(`/people/${person_id}`)
			.then( response => {
				return response.json()
			})
			.then( data => {
				document.getElementById("person_fullname").innerHTML = `${data.fullname}`
				document.getElementById("person_start_activity").innerHTML = `${data.start_activity}`
				document.getElementById("person_dni").innerHTML = `${data.dni} `
				document.getElementById("person_cuil").innerHTML = `${data.cuil}`
				document.getElementById("person_birth_date").innerHTML = `${data.birth_date}`
				document.getElementById("person_nationality").innerHTML = `${data.nationality}`
				document.getElementById("person_direction").innerHTML = `${data.direction}`
				document.getElementById("person_phone").innerHTML = `${data.phone}`

				if (data.dni_file != '') {
					document.getElementById("person_dni_file").innerText = 'Ver archivo'
					document.getElementById("person_dni_file").setAttribute('data-remote', 'false')
					document.getElementById("person_dni_file").setAttribute('target', '_blank')
					document.getElementById("person_dni_file").classList.remove('u-btn-outline-red')
					document.getElementById("person_dni_file").classList.add('u-btn-outline-purple')
					document.getElementById("person_dni_file").href = data.dni_file
				} else {
					document.getElementById("person_dni_file").innerText = 'Cargar PDF'
					document.getElementById("person_dni_file").setAttribute('target', '')
					document.getElementById("person_dni_file").setAttribute('data-remote', 'true')
					document.getElementById("person_dni_file").classList.remove('u-btn-outline-purple')
					document.getElementById("person_dni_file").classList.add('u-btn-outline-red')
					document.getElementById("person_dni_file").href = `/people/${data.id}/upload_person_file/dni_file?file_name=DNI`
				}

				if (data.cuil_file != '') {
					document.getElementById("person_cuil_file").innerText = 'Ver archivo'
					document.getElementById("person_cuil_file").setAttribute('data-remote', 'false')
					document.getElementById("person_cuil_file").setAttribute('target', '_blank')
					document.getElementById("person_cuil_file").classList.remove('u-btn-outline-red')
					document.getElementById("person_cuil_file").classList.add('u-btn-outline-purple')
					document.getElementById("person_cuil_file").href = data.cuil_file
				} else {
					document.getElementById("person_cuil_file").innerText = 'Cargar PDF'
					document.getElementById("person_cuil_file").setAttribute('target', '')
					document.getElementById("person_cuil_file").classList.remove('u-btn-outline-purple')
					document.getElementById("person_cuil_file").classList.add('u-btn-outline-red')
					document.getElementById("person_cuil_file").setAttribute('data-remote', 'true')
					document.getElementById("person_cuil_file").href = `/people/${data.id}/upload_person_file/cuil_file?file_name=CUIL`
				}

				if (data.start_activity_file != '') {
					document.getElementById("person_start_activity_file").innerText = 'Ver archivo'
					document.getElementById("person_start_activity_file").setAttribute('data-remote', 'false')
					document.getElementById("person_start_activity_file").setAttribute('target', '_blank')
					document.getElementById("person_start_activity_file").classList.remove('u-btn-outline-red')
					document.getElementById("person_start_activity_file").classList.add('u-btn-outline-purple')
					document.getElementById("person_start_activity_file").href = data.start_activity_file
				} else {
					document.getElementById("person_start_activity_file").innerText = 'Cargar PDF'
					document.getElementById("person_start_activity_file").setAttribute('target', '')
					document.getElementById("person_start_activity_file").classList.remove('u-btn-outline-purple')
					document.getElementById("person_start_activity_file").classList.add('u-btn-outline-red')
					document.getElementById("person_start_activity_file").setAttribute('data-remote', 'true')
					document.getElementById("person_start_activity_file").href = `/people/${data.id}/upload_person_file/start_activity_file?file_name=CUIL`
				}

				$('#person_information').show('slow')
				document.getElementById("form_people_documentation").reset()
				assignments_assigned_profiles.ajax.url(`/assignments_profiles/${person_id}?assignated=person`)
				assignments_assigned_profiles.ajax.reload(null,false)
				
				assignments_assigned_documents.ajax.url(`/assignments_documents/${person_id}?assignated=person`)
				assignments_assigned_documents.ajax.reload(null,false)
		})
		.catch( error => {
			console.log('Hubo un problema con la petición Fetch:' + error.message);
		})
	},
	populate_with_vehicle_data: () => {
		let vehicle_id = document.getElementById("vehicle_select").value
		document.getElementById('assignated_id').value = vehicle_id
		fetch(`/vehicles/${vehicle_id}`)
			.then( response => {
				return response.json()
			})
			.then( data => {
				document.getElementById("vehicle_code").innerHTML = `${data.code}`
				document.getElementById("vehicle_brand").innerHTML = `${data.brand}`
				document.getElementById("vehicle_domain").innerHTML = `${data.domain} `
				document.getElementById("vehicle_year").innerHTML = `${data.year}`
				document.getElementById("vehicle_model").innerHTML = `${data.model}`
				document.getElementById("vehicle_type").innerHTML = `${data.type}`

				$('#vehicle_information').show('slow')
				document.getElementById("form_vehicle_documentation").reset()
				assignments_assigned_profiles.ajax.url(`/assignments_profiles/${vehicle_id}?assignated=vehicle`)
				assignments_assigned_profiles.ajax.reload(null,false)
				
				assignments_assigned_documents.ajax.url(`/assignments_documents/${vehicle_id}?assignated=vehicle`)
				assignments_assigned_documents.ajax.reload(null,false)
		})
		.catch( error => {
			console.log('Hubo un problema con la petición Fetch:' + error.message);
		})
	}
}

$(document).ready(function(){
	if (document.getElementById('assigned_type') != undefined) {
		
		let select_placeholder = ( document.getElementById('assigned_type').value == 'people' ) ? 'Seleccione persona' : 'Seleccione interno'
		$('.assigned_select_data').select2({ width: '100%',theme: "bootstrap4", placeholder: select_placeholder })
		assignments_assigned_profiles = $("#assignments_assigned_profiles_table").DataTable({
			"columnDefs": [
		    { "width": "40%", "targets": 0 }
		  ],
			'columns': [
			 {'data': 'profile'},
			 {'data': 'start_date'},
			 {'data': 'end_date'},
			 {'data': 'status'}
			],
			'language': {'url': datatables_lang}
		})
		assignments_assigned_documents = $("#assignments_assigned_documents_table").DataTable({
			'columns': [
			 {'data': 'document'},
			 {'data': 'category'},
			 {'data': 'expire'},
			 {'data': 'expire_date'},
			 {'data': 'file'},
			 {'data': 'actions'}
			],
			'language': {'url': datatables_lang}
		})
	}

})

