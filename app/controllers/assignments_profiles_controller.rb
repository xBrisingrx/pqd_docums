class AssignmentsProfilesController < ApplicationController
	before_action :set_assignments_profile, only: %i[ edit update ]

  def show
    if params[:assignated] == 'person'
      data = Person.find params[:id]
    else 
      data = Vehicle.find params[:id]
    end
    @profiles = data.assignments_profiles
  end

	def create
    @assignments_profile = AssignmentsProfile.new(assignments_profile_params)
    respond_to do |format|
      if @assignments_profile.save
        format.json { render json: { status: :success, msg: 'Perfil asignado.' }, status: :created }
        # format.html { redirect_to people_profile_url(@assignments_profile), notice: "People profile was successfully created." }
      else
        format.json { render json: @assignments_profile.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
  	respond_to do |format|
      if @assignments_profile.update(assignments_profile_params)
        format.json { render json: { status: :success, msg: 'Asignación actualizada.' }, status: :ok }
        # format.html { redirect_to people_profile_url(@assignments_profile), notice: "People profile was successfully updated." }
      else
        format.json { render json: @assignments_profile.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable 
    assignments_profile = AssignmentsProfile.find(params[:assignment_profile_id])
    respond_to do |format|
      if assignments_profile.disable( params[:end_date] )
        format.json { render json: { status: :success, msg: 'Desvinculacion exitosa' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion', errors: @assignments_profile.erros }, status: :unprocessable_entity }
      end
    end
  end

  def reactive_profile 
    @assignments_profile = AssignmentsProfile.find(params[:assignment_profile_id])
    respond_to do |format|
      if @assignments_profile.reactive_profile( params[:start_date] )
        format.json { render json: { status: :success, msg: 'Reactivación exitosa' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion', errors: @assignments_profile.erros }, status: :unprocessable_entity }
      end
    end
  end

	private
    def set_assignments_profile
      @assignments_profile = AssignmentsProfile.find(params[:id])
    end

    def assignments_profile_params
      params.require(:assignments_profile).permit(:assignated_type, :assignated_id, :profile_id, 
        :start_date, :end_date, :active)
    end
end
