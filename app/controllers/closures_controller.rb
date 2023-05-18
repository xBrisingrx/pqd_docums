class ClosuresController < ApplicationController
  def index
    @closures = Closure.all
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

  private
    def set_closure
      @closure = Closure.find(params[:id])
    end

    def closure_params
      params.require(:closure).permit(:name, :start_date, :end_date)
    end
end
