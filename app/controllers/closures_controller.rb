class ClosuresController < ApplicationController
  before_action :set_closure, only: %i[ modal_send_report ]
  def index
    @closures = Closure.all.order(start_date: 'DESC')
    @title_modal = 'Cierres registrados'
  end

  def new
    @closure = Closure.new
    @title_modal = 'Registrar cierre'
  end

  def create
    @closure = Closure.new(closure_params)
    @closure.name = "Cierre ##{Closure.all.count + 1}"
    respond_to do |format|
      if @closure.save
        format.json { render json: { status: 'success', msg: 'Cierre generado' }, status: :created}
      else
        format.json { render json: @closure.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_tickets
    @closure = Closure.find( params[:closure_id] )
    @tickets = @closure.tickets
  end

  def modal_send_report
    @title_modal = "Marcar este reporte como enviado"
  end

  def set_was_send
    closure = Closure.find( params[:closure_id] )
    if closure.set_was_send
      render json: {  status: 'success', msg: 'Cierre marcado como enviado' }
    else
      render json: {  status: 'error', msg: 'No se pudo marcar el cierre como enviado' }
    end
  end

  private
    def set_closure
      @closure = Closure.find(params[:id])
    end

    def closure_params
      params.require(:closure).permit(:name, :start_date, :end_date)
    end

    def gen_closures
      # los clousures son una agrupacion de tickets 
      tickets = FuelToVehicle.actives.order(:date)
      first_ticket = tickets.first.date
      last_ticket = tickets.last.date
      start_date = Time.new( first_ticket.year, first_ticket.month, 1 )
      end_date = Time.new( last_ticket.year, last_ticket.month, 1 )

      while start_date <= end_date
        closure = Closure.where( 'extract(month  from start_date) = ?', start_date.month )
                         .where( 'extract(year  from start_date) = ?', start_date.year )
        if closure.blank?
          start_period = Date.new( start_date.year, start_date.month, 26 )
          next_month = start_date.month + 1
          end_period = Date.new( start_date.year, next_month, 25 )
          Closure.create(
            start_date: start_period, 
            end_date: end_period,
            name: "Cierre periodo #{I18n.t("date.month_names")[start_date.month]} #{start_date.year}")
        end
        start_date += 1.month 
      end
    end
end
