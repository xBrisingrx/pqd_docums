class DocumentRenovationsController < ApplicationController
  before_action :set_document_renovation, only: %i[ show edit update destroy ]

  def index
    @assigned_document = AssignmentsDocument.find( params[:assignments_document_id] )
    @document_renovations = @assigned_document.document_renovations.actives.order(expiration_date: :DESC) 
    @document_renovation = DocumentRenovation.new
    @title_modal = "Renovaciones del documento #{@assigned_document.document.name}"
  end

  def show
  end

  def new
    @document_renovation = DocumentRenovation.new
  end

  def edit
  end

  def create
    @document_renovation = DocumentRenovation.new(document_renovation_params)
    respond_to do |format|
      if @document_renovation.save
        format.json { render json: { status: 'success', msg: 'Renovacion cargada' }, status: :created }
        format.html { redirect_to document_renovation_url(@document_renovation), notice: "Document renovation was successfully created." }
      else
        format.json { render json: {status: 'error', msg: @document_renovation.errors}, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @document_renovation.update(document_renovation_params)
        format.json { render json: { status: 'success', msg: 'Renovacion actualizada' }, status: :created }
      else
        format.json { render json: {status: 'error', msg: @document_renovation.errors}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document_renovation.destroy

    respond_to do |format|
      format.html { redirect_to document_renovations_url, notice: "Document renovation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show_files
    @document_renovation = DocumentRenovation.find(params[:document_renovation_id])
    @title_modal = 'Archivos de renovaciones'
  end

  def disable
    @document_renovation = DocumentRenovation.find(params[:document_renovation_id])
    respond_to do |format|
      if @document_renovation.disable
        format.json { render json: { status: 'success', msg: 'Renovacion eliminada' }, status: :ok }
      else
        format.json { render json: {status: 'error', msg: @document_renovation.errors},status: :unprocessable_entity }
      end
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    def set_document_renovation
      @document_renovation = DocumentRenovation.find(params[:id])
    end

    def document_renovation_params
      params.require(:document_renovation).permit(:renovation_date, :expiration_date, :comment, :assignments_document_id, files: [])
    end
end
