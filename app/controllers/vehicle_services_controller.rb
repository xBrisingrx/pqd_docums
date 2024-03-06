class VehicleServicesController < ApplicationController
  before_action :set_vehicle_service, only: %i[ show edit update destroy ]

  # GET /vehicle_services or /vehicle_services.json
  def index # los services se filtran por vehiculo
    @vehicle_services = VehicleService.actives.order(:date, :desc)

    @vehicle = Vehicle.find params[:vehicle_id]
    @vehicle_services = @vehicle.vehicle_services.actives
    @vehicle_service = VehicleService.new
    @title_modal = "Services del vehiculo #{@vehicle.code}"
    @mileage_for_service = ( @vehicle.mileage_for_service.blank? ) ? 0 : @vehicle.mileage_for_service
    @hours_for_service = ( @vehicle.hours_for_service.blank? ) ? 0 : @vehicle.hours_for_service
    
  end

  # GET /vehicle_services/1 or /vehicle_services/1.json
  def show
  end

  # GET /vehicle_services/new
  def new
    @vehicle_service = VehicleService.new
  end

  # GET /vehicle_services/1/edit
  def edit
  end

  # POST /vehicle_services or /vehicle_services.json
  def create
    @vehicle_service = VehicleService.new(vehicle_service_params)

    respond_to do |format|
      if @vehicle_service.save
        format.json { render json: { status: 'success', msg: 'Service registrado' }, status: :created }
        format.html { redirect_to vehicle_service_url(@vehicle_service), notice: "Vehicle service was successfully created." }
      else
        format.json { render json: @vehicle_service.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_services/1 or /vehicle_services/1.json
  def update
    respond_to do |format|
      if @vehicle_service.update(vehicle_service_params)
        format.html { redirect_to vehicle_service_url(@vehicle_service), notice: "Vehicle service was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle_service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_services/1 or /vehicle_services/1.json
  def destroy
    @vehicle_service.destroy

    respond_to do |format|
      format.html { redirect_to vehicle_services_url, notice: "Vehicle service was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_service
      @vehicle_service = VehicleService.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_service_params
      params.require(:vehicle_service).permit(:date, :vehicle_id, :mileage, :mileage_next_service, :comment,:hours, :hours_next_service)
    end
end
