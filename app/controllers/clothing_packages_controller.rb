class ClothingPackagesController < ApplicationController
  before_action :set_clothing_package, only: %i[ show edit update destroy ]

  # GET /clothing_packages or /clothing_packages.json
  def index
    @clothing_packages = ClothingPackage.actives
  end

  # GET /clothing_packages/1 or /clothing_packages/1.json
  def show
  end

  # GET /clothing_packages/new
  def new
    @clothing_package = ClothingPackage.new
    @title_modal = "Registrar pack de ropa"
  end

  # GET /clothing_packages/1/edit
  def edit
    @title_modal = "Editando pack #{@clothing_package.name}"
  end

  # POST /clothing_packages or /clothing_packages.json
  def create
    @clothing_package = ClothingPackage.new(clothing_package_params)

    respond_to do |format|
      if @clothing_package.save
        format.json { render json: {status: 'success', msg: 'Paquete registrado'}, status: :created }
      else
        format.json { render json: @clothing_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clothing_packages/1 or /clothing_packages/1.json
  def update
    respond_to do |format|
      if @clothing_package.update(clothing_package_params)
        format.json { render json: {status: 'success', msg: 'Datos actualizados'}, status: :ok }
      else
        format.json { render json: @clothing_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clothing_packages/1 or /clothing_packages/1.json
  def disable
    clothing_package = ClothingPackage.find params[:clothing_package_id]
    activity_history = ActivityHistory.new( action: :disable, description: "Paquete #{clothing_package.name} dado de baja", 
      record: clothing_package, date: Time.now, user: current_user )
    if clothing_package.disable(current_user)
      render json: {status: 'success', msg: 'Paquete eliminado'}, status: :ok
    else 
      render json: {status: 'error', msg: 'No se pudo eliminar el paquete'}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clothing_package
      @clothing_package = ClothingPackage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clothing_package_params
      params.require(:clothing_package).permit(:name, :description, :days_of_validity, :active,
        clothes_packs_attributes: [:id, :clothe_id])
    end
end
