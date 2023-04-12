document_categories = [ 'General', 'Liquidación de haberes', 'Otros', 'Seguro', 'Sindicato' ]

document_categories.each do |category|
	DocumentCategory.create( name: category )
end

expiration_types = {
	'Semanal': 7,
	'Quincenal': 14,
	'Mensual': 30, 
	'Cuatrimestral': 120,
	'Semestral': 180,
	'Anual': 365,
	'Otro': 0
}

ExpirationType.create( name: 'No vence', days: 0, active: false )
expiration_types.each do |expiration|
	ExpirationType.create( name: expiration[0], days: expiration[1] )
end

User.create(name: 'MSSI', username: 'mssi', email: 'david@devtester.com', password: 'mauro01David', rol:1)
User.create(name: 'Ana', username: 'ana', email: 'ana.barros@pqdservicios.com', password: 'anab@pqd', rol:1)
User.create(name: 'Cecilia', username: 'cecilia', email: 'cecilia.nuin@pqdservicios.com', password: 'cec@nun', rol:1)
User.create(name: 'Fernando', username: 'fernando', email: 'fernando.astiz@pqdservicios.com', password: 'feras@pqd', rol:1)

reasons_to_disable = [
	{ reason: 'Renuncia', description: '', d_type: 1 },
	{ reason: 'Desvinculación', description: '', d_type: 1 },
	{ reason: 'Jubilación', description: '', d_type: 1 },
	{ reason: 'Venta', description: '', d_type: 2 },
	{ reason: 'Destrucción', description: '', d_type: 2 },
	{ reason: 'Acuerdo de partes', description: '', d_type: 1 },
	{ reason: 'Fallecimiento', description: 'Baja por Fallecimiento', d_type: 1 }
]

reasons_to_disable.each do |r|
	ReasonsToDisable.create(reason: r[:reason], d_type: r[:d_type], description: r[:description])
end

vehicles_types = ['Pick Up','Semirremolque','Tractor de Carretera + Hidrogrua','Chasis con Cabina',
	'Tractor con Cabina Dormitorio','Cargadora','Motoniveladora','Excavadora','Cargadora Retroexcavadora']

vehicles_types.each do |type| 
	VehicleType.create( name: type )
end 

vehicles_brands = ['TOYOTA' ,'FORD' ,'RANDON' 	,'IVECO',	'VOLVO' ,'MERCEDES BENZ' 	,'LAMBERT' 	,'CATERPILLAR','NISSAN']
vehicles_brands.each do |brand| 
	VehicleBrand.create( name: brand )
end 

vehicle_location = ['Comodoro Rivadavia']
vehicle_location.each do |location|
	VehicleLocation.create(name: location)
end