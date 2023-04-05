class DocumentCategoriesController < ApplicationController
  before_action :set_document_category, only: %i[ show edit update destroy ]

  # GET /document_categories or /document_categories.json
  def index
    @document_categories = DocumentCategory.all
  end

  # GET /document_categories/1 or /document_categories/1.json
  def show
  end

  # GET /document_categories/new
  def new
    @document_category = DocumentCategory.new
  end

  # GET /document_categories/1/edit
  def edit
  end

  # POST /document_categories or /document_categories.json
  def create
    @document_category = DocumentCategory.new(document_category_params)

    respond_to do |format|
      if @document_category.save
        format.html { redirect_to document_category_url(@document_category), notice: "Document category was successfully created." }
        format.json { render :show, status: :created, location: @document_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_categories/1 or /document_categories/1.json
  def update
    respond_to do |format|
      if @document_category.update(document_category_params)
        format.html { redirect_to document_category_url(@document_category), notice: "Document category was successfully updated." }
        format.json { render :show, status: :ok, location: @document_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_categories/1 or /document_categories/1.json
  def destroy
    @document_category.destroy

    respond_to do |format|
      format.html { redirect_to document_categories_url, notice: "Document category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_category
      @document_category = DocumentCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_category_params
      params.require(:document_category).permit(:name, :description, :active)
    end
end
