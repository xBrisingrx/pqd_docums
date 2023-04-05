class PeopleClothesController < ApplicationController
  before_action :set_people_clothe, only: %i[ show edit update destroy ]

  # GET /people_clothes or /people_clothes.json
  def index
    @person = Person.find params[:person_id]
    @people_clothes = @person.people_clothes
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

    respond_to do |format|
      if @people_clothe.save
        format.json { render json: { status: 'success', msg: 'Registro exitoso' }, status: :created }
      else
        format.json { render json: @people_clothe.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people_clothes/1 or /people_clothes/1.json
  def update
    respond_to do |format|
      if @people_clothe.update(people_clothe_params)
        format.html { redirect_to people_clothe_url(@people_clothe), notice: "People clothe was successfully updated." }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @people_clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people_clothes/1 or /people_clothes/1.json
  def destroy
    @people_clothe.destroy

    respond_to do |format|
      format.html { redirect_to people_clothes_url, notice: "People clothe was successfully destroyed." }
      format.json { head :no_content }
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
