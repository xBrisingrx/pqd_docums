class ReasonsToDisablesController < ApplicationController
  before_action :set_reasons_to_disable, only: %i[ show edit update destroy ]

  # GET /reasons_to_disables or /reasons_to_disables.json
  def index
    @reasons = ReasonsToDisable.where( d_type: params[:d_type]).where(active: true)
  end

  # GET /reasons_to_disables/1 or /reasons_to_disables/1.json
  def show
  end

  # GET /reasons_to_disables/new
  def new
    @title_modal = "Registrar motivo de baja"
    @reasons_to_disable = ReasonsToDisable.new
  end

  # GET /reasons_to_disables/1/edit
  def edit
    @title_modal = "Editar motivo: #{@reasons_to_disable.reason}"
  end

  # POST /reasons_to_disables or /reasons_to_disables.json
  def create
    @reasons_to_disable = ReasonsToDisable.new(reasons_to_disable_params)
    respond_to do |format|
      if @reasons_to_disable.save
        format.json { render json: { status: :success, msg: 'Motivo agregado.' } }
      else
        format.json { render json: @reasons_to_disable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reasons_to_disables/1 or /reasons_to_disables/1.json
  def update
    respond_to do |format|
      if @reasons_to_disable.update(reasons_to_disable_edit_params)
        format.json { render json: { status: :success, msg: 'Motivo editado.' } }
      else
        format.json { render json: @reasons_to_disable.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @reasons_to_disable = ReasonsToDisable.find(params[:reason_id])
    if @reasons_to_disable.update(active:false)
      render json: { status: 'success', msg: 'Motivo dado de baja' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reasons_to_disable
      @reasons_to_disable = ReasonsToDisable.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reasons_to_disable_params
      params.require(:reasons_to_disable).permit(:d_type, :reason, :description)
    end

    def reasons_to_disable_edit_params
      params.require(:reasons_to_disable).permit(:reason, :description)
    end
end
