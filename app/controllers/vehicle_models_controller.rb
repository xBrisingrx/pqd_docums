class VehicleModelsController < ApplicationController
  before_action :set_vehicle_model, only: %i[ show edit update destroy ]

  # GET /vehicle_models or /vehicle_models.json
  def index
    @vehicle_models = VehicleModel.actives.includes(:vehicle_brand)
    @vehicle_brands = VehicleBrand.actives
    @vehicle_model = VehicleModel.new
  end

  # GET /vehicle_models/1 or /vehicle_models/1.json
  def show
  end

  # GET /vehicle_models/new
  def new
    @vehicle_model = VehicleModel.new
  end

  # GET /vehicle_models/1/edit
  def edit
  end

  # POST /vehicle_models or /vehicle_models.json
  def create
    @vehicle_model = VehicleModel.new(vehicle_model_params)

    respond_to do |format|
      if @vehicle_model.save
        format.json { render json: { status: 'success', msg: 'Modelo registrado' }, status: :created }
        format.html { redirect_to vehicle_model_url(@vehicle_model), notice: "Vehicle model was successfully created." }
      else
        format.json { render json: @vehicle_model.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_models/1 or /vehicle_models/1.json
  def update
    respond_to do |format|
      if @vehicle_model.update(vehicle_model_params)
        format.json { render json: { status: 'success', msg: 'Modelo actualizado' }, status: :ok }
      else
        format.json { render json: @vehicle_model.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    vehicle_model = VehicleModel.find(params[:vehicle_model_id])
    activity_history = ActivityHistory.new( action: :disable, description: "Se dio de baja la marca de vehículo #{vehicle_model.name}", 
      record: vehicle_model, date: Time.now, user: current_user )
    
    respond_to do |format|
      if vehicle_model.update(active: false) && activity_history.save
        format.json { render json: { status: 'success', msg: 'Marca dada de baja' }, status: :ok }
      else
        format.json { render json: { status: 'error', msg: 'No se pudo dar de baja la marca', errors: vehicle_model.errors }, status: :unprocessable_entity }
      end # commit
    end # respond_to
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_model
      @vehicle_model = VehicleModel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_model_params
      params.require(:vehicle_model).permit(:name, :active, :description, :vehicle_brand_id)
    end
end
