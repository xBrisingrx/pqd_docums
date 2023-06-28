class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy show_vehicle_history modal_enable_vehicle show_images get_images ]
  before_action :set_vehicle_data, only: %i[ new edit ]

  # GET /vehicles or /vehicles.json
  def index
    @vehicles = Vehicle.actives
    @reasons_to_disable = ReasonsToDisable.vehicles.actives
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.json { render json: { status: :success, msg: 'Vehiculo registrado' }, status: :created }
        format.html { redirect_to vehicle_url(@vehicle), notice: "Vehicle was successfully created." }
      else
        format.json { render json: { status: 'error', msg: @vehicle.errors.messages }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.json { render json: { status: :success, msg: 'Datos actualizados' }, status: :ok }
        format.html { redirect_to vehicle_url(@vehicle), notice: "Vehicle was successfully updated." }
      else
        format.json { render json: { status: 'error', msg: @vehicle.errors.messages }, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    vehicle = Vehicle.find(params[:vehicle_id])
    activity_history = ActivityHistory.new( action: :disable, description: params[:description], 
      record: vehicle, date: params[:date], user: current_user, reasons_to_disable_id: params[:reasons_to_disable_id] )

    if vehicle.disable(params[:date]) && activity_history.save
      render json: { status: 'success', msg: 'Unidad eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'No se pudo eliminar esta unidad' }, status: :unprocessable_entity
    end

    rescue => e
      response = e.message.split(':')
      render json: { response[0] => response[1] }, status: 402
  end

  def inactives
    @vehicles = Vehicle.inactives
  end

  def show_vehicle_history
    @title_modal = "Historial de #{@vehicle.code}"
    @activity = @vehicle.activity_histories.where(action: :disable).or( @vehicle.activity_histories.where(action: :enable) ).order( date: 'DESC' )
  end

  def modal_enable_vehicle
    @title_modal = 'Reactivando unidad'
  end

  def enable_vehicle
    vehicle = Vehicle.find params[:vehicle_id]
    activity = ActivityHistory.new( action: :enable, description: params[:description], 
      record: vehicle, date: params[:date], user: current_user )
    if vehicle.enable && activity.save
      render json: { status: 'success', msg: "La unidad #{vehicle.code} fue reactivada" }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end
  end

  def show_images
    @title_modal = "Imágenes del vehículo #{@vehicle.code}"
  end

  def get_images
    images = @vehicle.images.map do |image|
      { id: image.signed_id , url: rails_blob_path(image , only_path: true)}
    end
    
    render json: { images: images }
  end

  def delete_image_attachment
    image = ActiveStorage::Blob.find_signed(params[:id])
    vehicle = Vehicle.find params[:vehicle_id]
    if vehicle.images.where(blob_id:image.id).first.purge
      render json: { status: 'success', msg: 'Imagen eliminada'  }, status: :ok
    else 
      render json: { status: 'error', msg: image.errors.messages  }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def set_vehicle_data
      @types = VehicleType.actives 
      @brands = VehicleBrand.actives 
      @models = VehicleModel.actives.includes(:vehicle_brand)
      @locations = VehicleLocation.actives 
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(:code, :domain, :chassis, :engine, :observations,
          :year, :vehicle_type_id, :vehicle_model_id, :vehicle_location_id, :kilometers_for_service, :active, :is_company,images: [])
    end
end
