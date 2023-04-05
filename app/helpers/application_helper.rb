module ApplicationHelper
	def active_class(link_path)
	    current_page?(link_path) ? "active" : ""
	end

	def date_format date
		(date) ? date.strftime('%d-%m-%y') : ''
	end

	def status_format status
		( status ) ? '<p class="u-tags-v1 g-color-green g-brd-around g-brd-green g-bg-green-opacity-0_1 g-bg-green--hover g-color-white--hover g-py-2 g-px-5">Activo</p>' 
		: '<p class="u-tags-v1 g-color-pink g-brd-around g-brd-pink g-bg-pink-opacity-0_1 g-bg-pink--hover g-color-white--hover g-py-2 g-px-5">Inactivo</p>'
	end

	def action_format action
		case action
		when 'create_record'
			color = 'teal'
			label = 'Registrado'
		when 'update_record'
			color = 'purple'
			label = 'Actualización'
		when 'disable'
			color = 'red'
			label = 'Baja'
		when 'enable'
			color = 'green'
			label = 'Alta'
		end 
		tag = "<p class='u-tags-v1 g-color-#{color} g-brd-around g-brd-#{color} g-bg-#{color}-opacity-0_1 g-bg-#{color}--hover g-color-white--hover g-py-2 g-px-5'>#{label} #{}</p>".html_safe
		return tag
	end
end
