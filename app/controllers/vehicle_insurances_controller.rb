class VehicleInsurancesController < ApplicationController
	before_action :set_vehicle_insurance, only: %i[ edit update destroy show_files ]

  def index
    @vehicle = Vehicle.find params[:vehicle_id]
    @vehicle_insurances = @vehicle.vehicle_insurances.actives
    @vehicle_insurance = VehicleInsurance.new
    @title_modal = "Seguros del vehiculo #{@vehicle.code}"
  end

  def show
  	vehicle = Vehicle.find params[:id]
  	vehicle_insurances = vehicle.vehicle_insurances.actives
  end

  def new
    @insurance = VehicleInsurance.new
    @title_modal = 'Crear empresa'
  end

  def edit
    @title_modal = "Editar empresa: #{@insurance.name}"
  end

  def create
    @vehicle_insurance = VehicleInsurance.new(vehicle_insurance_params)
    activity_history = ActivityHistory.new( action: :create_record, description: "El usuario #{current_user.username} 
      agrego el seguro #{@vehicle_insurance.insurance.name} al vehiculo #{@vehicle_insurance.vehicle.code}", 
      record: @vehicle_insurance, date: Time.now, user: current_user )
    respond_to do |format|
      if @vehicle_insurance.save && activity_history.save
        format.json { render json: { status: :success, msg: 'Aseguradora asignada al vehiculo.' }, status: :created, location: @vehicle_insurance }
      else
        format.json { render json: @vehicle_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # activity_history = ActivityHistory.new( action: :update_record, description: "El usuario #{current_user.username} actualizo datos de la empresa #{@insurance.name}", 
    #   record: @insurance, date: Time.now, user: current_user )
    respond_to do |format|
      if @insurance.update(vehicle_insurance_params) 
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok, location: @insurance }
      else
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    insurance = Insurance.find(params[:insurance_id])
    activity_history = ActivityHistory.new( action: :disable, description: "El usuario #{current_user.username} elimino la empresa #{insurance.name}", 
      record: insurance, date: Time.now, user: current_user )
    if insurance.update(active:false) && activity_history.save
      render json: { status: 'success', msg: 'Empresa eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  def show_files
    @title_modal = 'Archivos de aseguradora'
  end

  private
    def set_vehicle_insurance
      @vehicle_insurance = VehicleInsurance.find(params[:id])
    end

    def vehicle_insurance_params
      params.require(:vehicle_insurance).permit(:vehicle_id, :insurance_id, :policy, :start_date, :end_date, files: [])
    end
end
