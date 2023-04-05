class InsurancesController < ApplicationController
  before_action :set_insurance, only: %i[ show edit update ]

  def index
    @insurances = Insurance.actives
  end

  def show
  end

  def new
    @insurance = Insurance.new
    @title_modal = 'Registrar aseguradora'
    @vehicles = Vehicle.actives
  end

  def edit
    @title_modal = "Editando aseguradora #{@insurance.name}"
    @vehicles = Vehicle.actives
  end

  def create
    @insurance = Insurance.new(insurance_params)
    
    respond_to do |format|
      activity_history = ActivityHistory.new( action: :create_record, description: "Se registro la aseguradora #{@insurance.name}", 
      record: @insurance, date: Time.now, user: current_user )
      if @insurance.save
        format.json { render json: { status: 'success', msg: 'Aseguradora registrada.' }, status: :created }
      else
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @insurance.update(insurance_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok }
        format.html { redirect_to insurance_url(@insurance), notice: "Insurance was successfully updated." }
      else
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    insurance = Insurance.find(params[:insurance_id])
    activity_history = ActivityHistory.new( action: :disable, description: "El usuario #{current_user.username} elimino la aseguradora #{insurance.name}", 
      record: insurance, date: Time.now, user: current_user )
    if insurance.disable( current_user ) && activity_history.save
      render json: { status: 'success', msg: 'Aseguradora eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance
      @insurance = Insurance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def insurance_params
      params.require(:insurance).permit(:name, :description, :active, 
        vehicle_insurances_attributes: [:id, :vehicle_id, :policy, :start_date, :end_date])
    end
end
