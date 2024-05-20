class WeeklyMailer < ApplicationMailer
	default :from => 'reportes@pqdservicios.com'

	def vehicles_report
  	attachments['reporte_vehiculos.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_vehiculos.xlsx"))
    attachments['reporte_personas.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_personas.xlsx"))
    mail( :to => ['ana.barros@pqdservicios.com',
                  'cecilia.nuin@pqdservicios.com',
                  'nicolas.astiz@pqdservicios.com'],
    :subject => 'Informe semanal' )
  end

  def weekly_report email
    attachments['reporte_vehiculos.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_vehiculos.xlsx"))
    attachments['reporte_personas.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_personas.xlsx"))
    mail( to: email, subject: "Informe semanal")
  end
end


