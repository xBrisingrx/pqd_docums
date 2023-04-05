class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]

  def index
    @profiles = Profile.where(d_type: params[:d_type])
    @profile_type = ( params[:d_type] == 'people' ) ? 'personal' : 'vehiculos'
  end

  def show
  end

  def new
    @profile = Profile.new
    profile_type = ( params[:d_type] == 'people' ) ? 'personal' : 'vehiculos'
    @title_modal = "Registro de perfil para #{profile_type}"
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)
    activity_history = ActivityHistory.new( action: :create_record, description: "El usuario #{current_user.username} registro el perfil #{@profile.name}", 
      record: @profile, date: Time.now, user: current_user )
    respond_to do |format|
      if @profile.save && activity_history.save
        format.json { render json: { status: :success, msg: 'Perfil agregado.' }, status: :created }
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
      else
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    activity_history = ActivityHistory.new( action: :update_record, description: "El usuario #{current_user.username} actualizo el perfil #{@profile.name}", 
      record: @profile, date: Time.now, user: current_user )
    respond_to do |format|
      if @profile.update(profile_params) && activity_history.save
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok, location: @profile }
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
      else
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @profile = Profile.find(params[:profile_id])
    activity_history = ActivityHistory.new( action: :disable, description: "El usuario #{current_user.username} dio de baja el perfil #{@profile.name}", 
      record: @profile, date: Time.now, user: current_user )
    respond_to do |format|
      if @profile.disable( end_date: params[:end_date] ) && activity_history.save
        format.json { render json: { status: 'success', msg: 'Perfil eliminado' }, status: :ok }
      else
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:d_type, :name, :start_date, :end_date, :description)
    end
end
