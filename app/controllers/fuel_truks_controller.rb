class FuelTruksController < ApplicationController
  before_action :set_fuel_truk, only: %i[ show edit update destroy ]

  # GET /fuel_truks or /fuel_truks.json
  def index
    @fuel_truks = FuelTruk.all
  end

  # GET /fuel_truks/1 or /fuel_truks/1.json
  def show
  end

  # GET /fuel_truks/new
  def new
    @fuel_truk = FuelTruk.new
    @title_modal = "Registrar camion de carga de combustible"
  end

  # GET /fuel_truks/1/edit
  def edit
  end

  # POST /fuel_truks or /fuel_truks.json
  def create
    @fuel_truk = FuelTruk.new(fuel_truk_params)

    respond_to do |format|
      if @fuel_truk.save
        format.json { render json: {status: 'success', msg: 'Camion registrado'} , status: :created }
        format.html { redirect_to fuel_truk_url(@fuel_truk), notice: "Fuel truk was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fuel_truk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fuel_truks/1 or /fuel_truks/1.json
  def update
    respond_to do |format|
      if @fuel_truk.update(fuel_truk_params)
        format.html { redirect_to fuel_truk_url(@fuel_truk), notice: "Fuel truk was successfully updated." }
        format.json { render :show, status: :ok, location: @fuel_truk }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fuel_truk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fuel_truks/1 or /fuel_truks/1.json
  def destroy
    @fuel_truk.destroy

    respond_to do |format|
      format.html { redirect_to fuel_truks_url, notice: "Fuel truk was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fuel_truk
      @fuel_truk = FuelTruk.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fuel_truk_params
      params.require(:fuel_truk).permit(:name, :description, :active)
    end
end
