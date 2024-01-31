class FuelToVehiclesController < ApplicationController
  before_action :set_fuel_to_vehicle, only: %i[ show edit update destroy ]

  # GET /fuel_to_vehicles or /fuel_to_vehicles.json
  def index
    @fuel_to_vehicles = FuelToVehicle.all
  end

  # GET /fuel_to_vehicles/1 or /fuel_to_vehicles/1.json
  def show
  end

  # GET /fuel_to_vehicles/new
  def new
    @fuel_to_vehicle = FuelToVehicle.new
    @title_modal = "Cargar combustible a vehiculo"
    @closure_date = Closure.where( was_send: true ).order(end_date: :desc).first&.end_date&.to_s
    @ticket_books = TicketBook.actives.where(completed: false)
  end

  # GET /fuel_to_vehicles/1/edit
  def edit
    @title_modal = "Editar carga de combustible"
    @diferents_dates = @fuel_to_vehicle.date != @fuel_to_vehicle.computable_date
    @ticket_books = TicketBook.actives.where(completed: false).or( TicketBook.where( id: @fuel_to_vehicle.ticket_book.id ) )
  end

  # POST /fuel_to_vehicles or /fuel_to_vehicles.json
  def create
    @fuel_to_vehicle = FuelToVehicle.new(fuel_to_vehicle_params)
    byebug
    raise 'none'
    respond_to do |format|
      if @fuel_to_vehicle.save
        format.json { render json: { status: 'success', msg: 'Carga registrada'}, status: :created }
      else
        format.json { render json: @fuel_to_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fuel_to_vehicles/1 or /fuel_to_vehicles/1.json
  def update
    # if @fuel.ticket != params[ticket] lo libero
    respond_to do |format|
      if @fuel_to_vehicle.update(fuel_to_vehicle_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados'}, status: :ok, location: @fuel_to_vehicle }
      else
        format.json { render json: @fuel_to_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fuel_to_vehicles/1 or /fuel_to_vehicles/1.json
  def destroy
    @fuel_to_vehicle.destroy

    respond_to do |format|
      format.html { redirect_to fuel_to_vehicles_url, notice: "Fuel to vehicle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fuel_to_vehicle
      @fuel_to_vehicle = FuelToVehicle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fuel_to_vehicle_params
      params.require(:fuel_to_vehicle).permit(
        :vehicle_id, 
        :fuel_supplier_id, 
        :person_load_id, 
        :person_authorize_id, 
        :date, 
        :fueling, 
        :mileage,
        :hours,
        :ticket,
        :fuel_type, 
        :date,
        :computable_date,
        :ticket_id)
    end
end
