json.set! :id, person.id
json.set! :dni, person.dni
json.set! :fullname, person.fullname
json.set! :start_activity, ( person.start_activity ) ? person.start_activity.strftime('%d / %m / %y') : ''
json.set! :expiration_date_dni, ''
json.set! :cuil, person.cuil
json.set! :birth_date, ( person.birth_date ) ? person.birth_date.strftime('%d / %m / %y') : ''
json.set! :nationality, person.nationality
json.set! :direction, person.direction
json.set! :phone, person.phone
json.set! :dni_file, person.dni_file.attached? ? url_for(person.dni_file) : ''
json.set! :cuil_file, person.cuil_file.attached? ? url_for(person.cuil_file) : ''
json.set! :start_activity_file, person.start_activity_file.attached? ? url_for(person.start_activity_file) : ''