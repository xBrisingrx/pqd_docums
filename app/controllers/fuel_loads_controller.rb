class FuelLoadsController < ApplicationController
  before_action :set_fuel_load, only: %i[ edit update destroy ]

  # GET /fuel_loads or /fuel_loads.json
  def index
    @fuel_loads = FuelLoad.all
  end

  # GET /fuel_loads/1 or /fuel_loads/1.json
  def show
    @loads = FuelLoad.where( fuel_truk_id: params[:id] )
    truk = FuelTruk.find params[:id]
    @title_modal = "Cargas realizadas al camion #{ truk.name }"
  end

  # GET /fuel_loads/new
  def new
    @fuel_load = FuelLoad.new
    @fuel_truk = FuelTruk.find params[:fuel_truk_id]
    @title_modal = "Cargar combustible al camion #{ @fuel_truk.name}"
  end

  # GET /fuel_loads/1/edit
  def edit
  end

  # POST /fuel_loads or /fuel_loads.json
  def create
    @fuel_load = FuelLoad.new(fuel_load_params)

    respond_to do |format|
      if @fuel_load.save
        format.json { render json: { status: 'success', msg: 'Carga registrada' }, status: :created, location: @fuel_load }
        format.html { redirect_to fuel_load_url(@fuel_load), notice: "Fuel load was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fuel_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fuel_loads/1 or /fuel_loads/1.json
  def update
    respond_to do |format|
      if @fuel_load.update(fuel_load_params)
        format.html { redirect_to fuel_load_url(@fuel_load), notice: "Fuel load was successfully updated." }
        format.json { render :show, status: :ok, location: @fuel_load }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fuel_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fuel_loads/1 or /fuel_loads/1.json
  def destroy
    @fuel_load.destroy

    respond_to do |format|
      format.html { redirect_to fuel_loads_url, notice: "Fuel load was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fuel_load
      @fuel_load = FuelLoad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fuel_load_params
      params.require(:fuel_load).permit(:fueling, :date, :active, :fuel_truk_id)
    end
end
