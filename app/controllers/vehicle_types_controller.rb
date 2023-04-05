class VehicleTypesController < ApplicationController
  before_action :set_vehicle_type, only: %i[ show edit update destroy ]

  # GET /vehicle_types or /vehicle_types.json
  def index
    @vehicle_types = VehicleType.all
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

    respond_to do |format|
      if @vehicle_type.save
        format.html { redirect_to vehicle_type_url(@vehicle_type), notice: "Vehicle type was successfully created." }
        format.json { render :show, status: :created, location: @vehicle_type }
      else
        format.html { render :new, status: :unprocessable_entity }
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

  # DELETE /vehicle_types/1 or /vehicle_types/1.json
  def destroy
    @vehicle_type.destroy

    respond_to do |format|
      format.html { redirect_to vehicle_types_url, notice: "Vehicle type was successfully destroyed." }
      format.json { head :no_content }
    end
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
