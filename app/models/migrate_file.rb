class MigrateFile < ApplicationRecord

	def self.set_dni_file
		files = MigrateFile.where( table: 'Person' )
		files.each do |file|
			dir_file = Rails.root.join("app/#{file.path}")
			if dir_file.exist?
				person = Person.find( file.table_id )

				case file.column
				when 'dni_file'
					person.dni_file.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
				when 'cuil_file'
					person.cuil_file.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
				when 'pdf_alta_temprana'
					person.start_activity_file.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
				else
					puts "naditas"
				end # case 
			else
				file.update( exist_file: false )
			end
		end # each 
	end # method

	def self.set_vehicle_img 
		files = MigrateFile.where( table: 'Vehicle' )
		count_files = 0
		files.each do |file|
			dir_file = Rails.root.join("app/#{file.path}")
			if dir_file.exist?
				count_files += 1
				vehicle = Vehicle.find( file.table_id )

				case file.column
				when 'imagenes'
					vehicle.images.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
				else
					puts "naditas"
				end # case 
			else
				file.update( exist_file: false )
			end
		end # each 
		puts "\n\n =============================== #{count_files} \n\n"
	end

	def self.set_vehicle_insurance
		files = MigrateFile.where( table: 'seguros_vehiculos' )
		count_files = 0
		files.each do |file|
			dir_file = Rails.root.join("app/#{file.path}")
			if dir_file.exist?
				count_files += 1
				vehicle_insurance = VehicleInsurance.find( file.table_id )

				case file.column
				when 'poliza'
					vehicle_insurance.files.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
				else
					puts "naditas"
				end # case 
			else
				file.update( exist_file: false )
			end
		end # each 
		puts "\n\n =============================== #{count_files} \n\n"
	end

	def self.set_people_renovations
		files = MigrateFile.where( table: 'DocumentRenovation' )
		count_files = 0
		files.each do |file|
			next if file.id == 38
			next if file.id == 39
			next if file.id == 40
			next if file.id == 41

			dir_file = Rails.root.join("app/#{file.path}")
			if dir_file.exist?
				count_files += 1
				renovation = DocumentRenovation.find( file.table_id )

				case file.column
				when 'renovacion'
					renovation.files.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
				else
					puts "naditas"
				end # case 
			else
				file.update( exist_file: false )
			end
		end # each 
		puts "\n\n =============================== #{count_files} \n\n"
	end

	def self.set_vehicles_renovations
		files = MigrateFile.where( table: 'renovaciones_atributos_vehiculos' )
		count_files = 0
		files.each do |file|
			
			dir_file = Rails.root.join("app/#{file.path}")
			if dir_file.exist?
				count_files += 1
				renovation = DocumentRenovation.find( file.table_id )

				case file.column
				when 'renovacion'
					renovation.files.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
				else
					puts "naditas"
				end # case 
			else
				file.update( exist_file: false )
			end
		end # each 
		puts "\n\n =============================== #{count_files} \n\n"
	end

	

end
