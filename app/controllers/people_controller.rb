class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update upload_person_file show_person_history modal_enable_person ]

  def index
    @people = Person.actives
    @reasons_to_disable = ReasonsToDisable.people.actives
    respond_to do |format|
      format.html
      format.json
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="all_people.xlsx"'
      }
    end
  end

  def show
    respond_to do |format|
      format.json { render :show, status: :ok }
    end
  end

  def new
    @person = Person.new
    @title_modal = 'Alta de persona'
  end

  def edit
    @title_modal = "Actualizar datos de: #{@person.fullname}"
  end

  def create
    @person = Person.new(person_params)
    respond_to do |format|
      if @person.save
        format.json { render json: { status: :success, msg: 'Persona registrada con éxito.'}, status: :created }
        format.html { redirect_to person_url(@person), notice: "Person was successfully created." }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.json { render json: { status: :success, msg: 'Datos actualizados.'}, status: :ok }
        format.html { redirect_to people_path, notice: "Person was successfully updated." }
      else
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @person = Person.find(params[:person_id])
    activity_history = ActivityHistory.new( action: :disable, description: params[:description], 
      record: @person, date: params[:date], user: current_user, reasons_to_disable_id: params[:reasons_to_disable_id] )

    if @person.update(active:false) && activity_history.save
      render json: { status: 'success', msg: 'Persona eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  def upload_person_file
    @title_modal = "Cargar archivo de #{params[:file_name]} a #{ @person.fullname }"
    @file = params[:file]
  end

  def dato_disponible # Verificamos que el dato no este en uso
    person = Person.where("#{params['attribute']}" => params['value']).first

    if person.nil?
      render json: 'true'
    else
      if !params['person_id'].blank?
        if params['person_id'].to_i == person.id
          render json: 'true'
        else
          render json: 'false'
        end
      else
        render json: 'false'
      end
    end
  end

  def inactives
    @people = Person.inactives
  end

  def show_person_history
    @title_modal = "Historial de #{@person.fullname}"
    @activity = @person.activity_histories.where(action: :disable).or( @person.activity_histories.where(action: :enable) ).order( date: 'DESC' )
  end

  def modal_enable_person
    @title_modal = 'Reactivando persona'
  end

  def enable_person
    person = Person.find params[:person_id]
    activity = ActivityHistory.new( action: :enable, description: params[:description], 
      record: person, date: params[:date], user: current_user )
    if person.enable && activity.save
      render json: { status: 'success', msg: 'Persona reactivada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end
  end

  def permission_fuel_load
    @people = Person.actives
  end

  def set_permission
    person = Person.find(params[:id])
    pp person
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:file, :name, :last_name, :dni, :dni_has_expiration, 
        :date_expiration_dni, :birth_date, :nationality, :direction, :phone, :date_start_activity, 
        :dni_file, :cuil_file, :start_activity_file, :tramit_number, :cuil, :start_activity, :email, :can_authorize, :load_with_ticket, :load_with_km)
    end
end
