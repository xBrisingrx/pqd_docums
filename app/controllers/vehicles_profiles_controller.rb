class VehiclesProfilesController < ApplicationController
	before_action :set_vehicles_profile, only: %i[ show edit update destroy ]

  def index
    @vehicles_profiles = AssignmentsProfile.vehicles
  end

  def show
  end

  def new
    @vehicles_profile = AssignmentsProfile.new( assignated_type: :Vehicle )
    @vehicles = Vehicle.actives.order(:code)
    @profiles = Profile.of_vehicles.actives
    @title_modal = 'Asignar perfil a un vehiculo'
  end

  def edit
    @documents = @vehicles_profile.zone_job_profile.documents
  end

  def modal_disable
    @vehicle_profile = AssignmentsProfile.find(params[:vehicles_profile_id])
    @documents = @vehicle_profile.zone_job_profile.documents
  end

  private
    def set_vehicles_profile
      @vehicles_profile = AssignmentsProfile.find(params[:id])
    end

    def vehicles_profile_params
      params.permit(:assignated_id, :profile_id, :start_date, :end_date, :active)
    end
end
