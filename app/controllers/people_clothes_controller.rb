class PeopleClothesController < ApplicationController
  before_action :set_people_clothe, only: %i[ show edit update destroy ]

  # GET /people_clothes or /people_clothes.json
  def index
    @person = Person.find params[:person_id]
    @people_clothes = @person.people_clothes.actives
    @person_clothe = PeopleClothe.new( person_id: @person.id )
    @title_modal = "Ropa entregada a #{@person.fullname}"
  end

  # GET /people_clothes/1 or /people_clothes/1.json
  def show
    
  end

  # GET /people_clothes/new
  def new
    @people_clothe = PeopleClothe.new
  end

  # GET /people_clothes/1/edit
  def edit
  end

  # POST /people_clothes or /people_clothes.json
  def create
    @people_clothe = PeopleClothe.new(people_clothe_params)
    activity_history = ActivityHistory.new( action: :create_record, 
      description: "El usuario #{current_user.username} hizo la entrega de ropa #{@people_clothe.clothing_package.name} a #{@people_clothe.person.fullname}", 
      record: @people_clothe, 
      date: Time.now, user: current_user )
    respond_to do |format|
      if @people_clothe.save && activity_history.save
        format.json { render json: { status: 'success', msg: 'Registro exitoso' }, status: :created }
      else
        format.json { render json: @people_clothe.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people_clothes/1 or /people_clothes/1.json
  def update
    activity_history = ActivityHistory.new( action: :update_record, 
      description: "El usuario #{current_user.username} actualizo la entrega de ropa #{@people_clothe.clothing_package.name} de #{@people_clothe.person.fullname}", 
      record: @people_clothe, 
      date: Time.now, user: current_user )
    respond_to do |format|
      if @people_clothe.update(people_clothe_params) && activity_history.save
        format.html { redirect_to people_clothe_url(@people_clothe), notice: "People clothe was successfully updated." }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @people_clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    people_clothe = PeopleClothe.find(params[:person_clothe_id])
    activity_history = ActivityHistory.new( action: :disable, 
      description: "El usuario #{current_user.username} elimino la entrega de ropa #{people_clothe.clothing_package.name} con fecha #{ people_clothe.start_date } a #{people_clothe.person.fullname}", 
      record: people_clothe, 
      date: Time.now, user: current_user )
    respond_to do |format|
      if people_clothe.update( active: false ) && activity_history.save
        format.json { render json: { status: "success", msg: "Entrega eliminada" }, status: :ok }
      else
        format.json { render json: { status: "error", msg: @people_clothe.errors}, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_people_clothe
      @people_clothe = PeopleClothe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def people_clothe_params
      params.require(:people_clothe).permit(:person_id, :clothing_package_id, :start_date, :end_date, :expires)
    end
end
