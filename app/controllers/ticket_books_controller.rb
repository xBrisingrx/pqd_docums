class TicketBooksController < ApplicationController
  before_action :set_ticket_book, only: %i[ show edit update destroy modal_closed set_closed]

  # GET /ticket_books or /ticket_books.json
  def index
    @title_modal = "Talonarios"
    @ticket_books = TicketBook.actives.includes(:tickets)
  end

  # GET /ticket_books/1 or /ticket_books/1.json
  def show
  end

  # GET /ticket_books/new
  def new
    @title_modal = "Registrar talonario"
    @ticket_book = TicketBook.new
  end

  # GET /ticket_books/1/edit
  def edit
  end

  # POST /ticket_books or /ticket_books.json
  def create
    @ticket_book = TicketBook.new(name: params[:ticket_book][:name])
    respond_to do |format|
      if @ticket_book.create_ticket_book( params[:ticket_book][:ticket_from].to_i, params[:ticket_book][:ticket_until].to_i )
        format.json { render json: { status: 'success', msg: 'Talonario registrado' }, status: :created}
      else
        format.json { render json: @ticket_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_books/1 or /ticket_books/1.json
  def update
    respond_to do |format|
      if @ticket_book.update(ticket_book_params)
        format.html { redirect_to ticket_book_url(@ticket_book), notice: "Ticket book was successfully updated." }
        format.json { render :show, status: :ok}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_book.errors, status: :unprocessable_entity }
      end
    end
  end

  def modal_closed
    pp @ticket_book
    @title_modal = "Cerrar talonario"
  end

  def set_closed
    respond_to do |format|
      if @ticket_book.set_closed
        format.json { render json: { status: 'success', msg: 'Talonario cerradi' }, status: :ok}
      else
        format.json { render json: @ticket_book.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_tickets
    ticket_book = TicketBook.find(params[:id])
    render json: { tickets: ticket_book.tickets.unused.order(number: :asc) }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_book
      @ticket_book = TicketBook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_book_params
      params.require(:ticket_book).permit(:name, :status, :active)
    end
end
