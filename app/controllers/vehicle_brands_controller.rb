class VehicleBrandsController < ApplicationController
  before_action :set_vehicle_brand, only: %i[ show edit update destroy ]

  # GET /vehicle_brands or /vehicle_brands.json
  def index
    @vehicle_brands = VehicleBrand.actives
    @vehicle_brand = VehicleBrand.new
  end

  # GET /vehicle_brands/1 or /vehicle_brands/1.json
  def show
  end

  # GET /vehicle_brands/new
  def new
    @vehicle_brand = VehicleBrand.new
  end

  # GET /vehicle_brands/1/edit
  def edit
  end

  # POST /vehicle_brands or /vehicle_brands.json
  def create
    @vehicle_brand = VehicleBrand.new(vehicle_brand_params)
    activity_history = ActivityHistory.new( action: :create_record, description: "Se registro la marca de vehículo #{@vehicle_brand.name}", 
      record: @vehicle_brand, date: Time.now, user: current_user )
    respond_to do |format|
      if @vehicle_brand.save && activity_history.save
        format.json { render json: { status: 'success', msg: 'Marca registrada' }, status: :created}
        format.html { redirect_to vehicle_brand_url(@vehicle_brand), notice: "Vehicle brand was successfully created." }
      else
        format.json { render json: @vehicle_brand.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_brands/1 or /vehicle_brands/1.json
  def update
    respond_to do |format|
      if @vehicle_brand.update(vehicle_brand_params)
        format.json { render json: { status: 'success', msg: 'Marca actualizada' }, status: :ok}
        format.html { redirect_to vehicle_brand_url(@vehicle_brand), notice: "Vehicle brand was successfully updated." }
      else
        format.json { render json: @vehicle_brand.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    vehicle_brand = VehicleBrand.find(params[:vehicle_brand_id])
    activity_history = ActivityHistory.new( action: :disable, description: "Se dio de baja la marca de vehículo #{vehicle_brand.name}", 
      record: vehicle_brand, date: Time.now, user: current_user )
    
    respond_to do |format|
      if vehicle_brand.update(active: false) && activity_history.save
        format.json { render json: { status: 'success', msg: 'Marca dada de baja' }, status: :ok }
      else
        format.json { render json: { status: 'error', msg: 'No se pudo dar de baja la marca', errors: vehicle_brand.errors }, status: :unprocessable_entity }
      end # commit
    end # respond_to
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_brand
      @vehicle_brand = VehicleBrand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_brand_params
      params.require(:vehicle_brand).permit(:name, :active, :description)
    end
end
