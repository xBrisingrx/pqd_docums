class ExpirationTypesController < ApplicationController
  before_action :set_expiration_type, only: %i[ show edit update destroy ]

  # Tipos de vencimiento lo uso para estandarizar cada cuanto caduca un documento [semanal, mensual, anual, custom]

  def index
    @expiration_types = ExpirationType.all
  end

  def show
  end

  def new
    @expiration_type = ExpirationType.new
  end

  def edit
  end

  def create
    @expiration_type = ExpirationType.new(expiration_type_params)

    respond_to do |format|
      if @expiration_type.save
        format.html { redirect_to expiration_type_url(@expiration_type), notice: "Expiration type was successfully created." }
        format.json { render :show, status: :created, location: @expiration_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expiration_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expiration_type.update(expiration_type_params)
        format.html { redirect_to expiration_type_url(@expiration_type), notice: "Expiration type was successfully updated." }
        format.json { render :show, status: :ok, location: @expiration_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expiration_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expiration_type.destroy

    respond_to do |format|
      format.html { redirect_to expiration_types_url, notice: "Expiration type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_expiration_type
      @expiration_type = ExpirationType.find(params[:id])
    end

    def expiration_type_params
      params.require(:expiration_type).permit(:name, :description, :active)
    end
end
