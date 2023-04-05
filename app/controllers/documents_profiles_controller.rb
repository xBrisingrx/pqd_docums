class DocumentsProfilesController < ApplicationController
  before_action :set_documents_profile, only: %i[ show edit update modal_disable ]

  def index
    @documents_profiles = DocumentsProfile.where(d_type: params[:d_type])
  end

  def show
  end

  def new
    @documents_profile = DocumentsProfile.new
    @title_modal = 'Agregar documento a un perfil'
    @profiles = Profile.where( d_type: params[:d_type]).actives
    @documents = Document.where( d_type: params[:d_type]).actives
  end

  def edit
    @title_modal = 'Editar'
    @profiles = Profile.where( d_type: @documents_profile.d_type).actives
    @documents = Document.where( d_type: @documents_profile.d_type).actives
  end

  def create
    ActiveRecord::Base.transaction do
      for i in 1..params[:count].to_i do 
        entry = DocumentsProfile.new(
          profile_id: params[:profile_id],
          d_type: params[:d_type],
          document_id: params["document_#{i}".to_sym].to_i,
          start_date: params["start_date_#{i}".to_sym]
        )
        entry.assignment_documents_to_profile
      end
      entry.update_asociations
      render json: { status: :success, msg: 'Asociacion exitosa' }, status: :ok
    end
    rescue StandardError => e
      render json: { status: :info, msg: e.message }, status: :ok
    rescue ActiveRecord::RecordInvalid
      render json: { status: :error, msg: 'No se pudieron asociar los documentos' }, status: :unprocessable_entity
  end

  def update
    respond_to do |format|
      if @documents_profile.update(document_profile_update_params)
        format.json {  render json: { status: :success, msg: 'Datos actualizados.' }, status: :ok, location: @documents_profile }
        format.html { redirect_to documents_profile_url(@documents_profile), notice: "Documents profile was successfully updated." }
      else
        format.json { render json: @documents_profile.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def modal_disable;end

  def disable
    @document_profile = DocumentsProfile.find(params[:document_profile_id])

    respond_to do |format|
      if @document_profile.update(active: false, end_date: params[:end_date])
        format.json { render json: { msg: 'Operacion exitosa', status: 'success' }, status: :ok }
      else
        format.json { render json: { msg: 'Ocurrio un error al realizar la operacion' }, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_documents_profile
      @documents_profile = DocumentsProfile.find(params[:id])
    end

    def documents_profile_params
      params.require(:documents_profile).permit(:profile_id, :document_id, :start_date, :end_date, :d_type)
    end

    def document_profile_update_params
      params.require(:documents_profile).permit(:start_date)
    end
end
