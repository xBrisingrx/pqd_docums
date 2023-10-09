class VehicleTypesController < ApplicationController
  before_action :set_vehicle_type, only: %i[ show edit update destroy ]

  # GET /vehicle_types or /vehicle_types.json
  def index
    @vehicle_types = VehicleType.actives
    @vehicle_type = VehicleType.new
  end

  # GET /vehicle_types/1 or /vehicle_types/1.json
  def show
  end

  # GET /vehicle_types/new
  def new
    @vehicle_type = VehicleType.new
  end

  # GET /vehicle_types/1/edit
  def edit
  end

  # POST /vehicle_types or /vehicle_types.json
  def create
    @vehicle_type = VehicleType.new(vehicle_type_params)
    activity_history = ActivityHistory.new( action: :create_record, description: "Se registro la marca de vehículo #{@vehicle_type.name}", 
      record: @vehicle_type, date: Time.now, user: current_user )
    respond_to do |format|
      if @vehicle_type.save && activity_history.save
        format.json { render json: { status: 'success', msg: 'Tipo de vehiculo registrado' }, status: :created}
      else
        format.json { render json: @vehicle_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_types/1 or /vehicle_types/1.json
  def update
    respond_to do |format|
      if @vehicle_type.update(vehicle_type_params)
        format.html { redirect_to vehicle_type_url(@vehicle_type), notice: "Vehicle type was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    vehicle_type = VehicleType.find(params[:vehicle_type_id])
    activity_history = ActivityHistory.new( action: :disable, description: "Se dio de baja el tipo de vehículo #{vehicle_type.name}", 
      record: vehicle_type, date: Time.now, user: current_user )
    
    respond_to do |format|
      if vehicle_type.update(active: false) && activity_history.save
        format.json { render json: { status: 'success', msg: 'Tipo de vehiculo dado de baja' }, status: :ok }
      else
        format.json { render json: { status: 'error', msg: 'No se pudo dar de baja el tipo', errors: vehicle_type.errors }, status: :unprocessable_entity }
      end # commit
    end # respond_to
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_type
      @vehicle_type = VehicleType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_type_params
      params.require(:vehicle_type).permit(:name, :active, :description)
    end
end
