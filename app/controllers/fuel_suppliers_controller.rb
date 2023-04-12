class FuelSuppliersController < ApplicationController
  before_action :set_fuel_supplier, only: %i[ show edit update destroy ]

  # GET /fuel_suppliers or /fuel_suppliers.json
  def index
    @fuel_suppliers = FuelSupplier.all
  end

  # GET /fuel_suppliers/1 or /fuel_suppliers/1.json
  def show
  end

  # GET /fuel_suppliers/new
  def new
    @fuel_supplier = FuelSupplier.new
    @title_modal = 'Registrar abastecedor'
  end

  # GET /fuel_suppliers/1/edit
  def edit
  end

  # POST /fuel_suppliers or /fuel_suppliers.json
  def create
    @fuel_supplier = FuelSupplier.new(fuel_supplier_params)

    respond_to do |format|
      if @fuel_supplier.save
        format.json { render json: { status: 'success', msg: 'Abastecedor registrado' }, status: :created }
        format.html { redirect_to fuel_supplier_url(@fuel_supplier), notice: "Fuel supplier was successfully created." }
      else
        format.json { render json: @fuel_supplier.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fuel_suppliers/1 or /fuel_suppliers/1.json
  def update
    respond_to do |format|
      if @fuel_supplier.update(fuel_supplier_params)
        format.json { render son: { status: 'success', msg: 'Datos actualizados' }, status: :ok }
        format.html { redirect_to fuel_supplier_url(@fuel_supplier), notice: "Fuel supplier was successfully updated." }
      else
        format.json { render json: @fuel_supplier.errors, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fuel_suppliers/1 or /fuel_suppliers/1.json
  def destroy
    @fuel_supplier.destroy

    respond_to do |format|
      format.html { redirect_to fuel_suppliers_url, notice: "Fuel supplier was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fuel_supplier
      @fuel_supplier = FuelSupplier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fuel_supplier_params
      params.require(:fuel_supplier).permit(:name, :description, :supplier_type)
    end
end
