class ClothesController < ApplicationController
  before_action :set_clothe, only: %i[ show edit update destroy ]

  def index
    @clothes = Clothe.actives
  end

  def show
  end

  def new
    @clothe = Clothe.new
    @title_modal = 'Registrar ropa'
  end

  def edit
    @title_modal = "Editar ropa: #{@clothe.name}"
  end

  def create
    @clothe = Clothe.new(clothe_params)
    activity_history = ActivityHistory.new( action: :create_record, description: "Ropa #{@clothe.name} registrada", 
      record: @clothe, date: Time.now, user: current_user )
    respond_to do |format|
      if @clothe.save && activity_history.save
        format.json { render json: { status: :success, msg: 'Ropa agregada.' }, status: :created, location: @clothe }
      else
        format.json { render json: @clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    activity_history = ActivityHistory.new( action: :update_record, description: "Ropa #{@clothe.name} actualizada", 
      record: @clothe, date: Time.now, user: current_user )
    respond_to do |format|
      if @clothe.update(clothe_edit_params) && activity_history.save
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok, location: @clothe }
      else
        format.json { render json: @clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    clothe = Clothe.find(params[:clothe_id])
    activity_history = ActivityHistory.new( action: :disable, description: "El usuario #{current_user.username} elimino la ropa #{clothe.name}", 
      record: clothe, date: Time.now, user: current_user )
    if clothe.disable(current_user) && activity_history.save
      render json: { status: 'success', msg: 'Ropa eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    def set_clothe
      @clothe = Clothe.find(params[:id])
    end

    def clothe_params
      params.require(:clothe).permit(:name, :description)
    end
end
