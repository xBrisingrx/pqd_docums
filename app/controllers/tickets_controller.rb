class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[edit update modal_detail_disable]
  def index
    @ticket_book_id = params[:ticket_book_id]
    @tickets = Ticket.where(ticket_book_id: @ticket_book_id)
    @title_modal = "Tickets"
  end

  def new
  end

  def create
  end

  def edit
    @title_modal = "Anular ticket ##{@ticket.number}"
  end

  def modal_change_status
    @ticket = Ticket.find(params[:id])
    @title_modal = "Anular ticket ##{@ticket.number}"
  end

  def modal_detail_disable
    @info = ActivityHistory.find_by(record: @ticket)
    byebug
  end

  def change_status
    ticket = Ticket.find(params[:id])
    ticket.active = !ticket.active
    if ticket.active
      msg = "Ticket habilitado"
      action = :enable
    else
      msg = "Ticket deshabilitado"
      action = :disable
    end
    if ticket.save
      ActivityHistory.create( action: action, description: params[:description], 
        record: ticket, date: params[:date], user: current_user )
      render json: { status: "success", msg: msg }, status: :ok
    else
      render json: { status: "error", msg: "Estado no actualizado" }, status: :unprocessable_entity
    end
  end

  def update
    @ticket.active = !@ticket.active
    if @ticket.active
      msg = "Ticket habilitado"
      action = :enable
    else
      msg = "Ticket deshabilitado"
      action = :disable
    end
    if @ticket.save
      ActivityHistory.create( action: action, description: params[:ticket][:description], 
        record: @ticket, date: params[:date], user: current_user )
      render json: { status: "success", msg: msg }, status: :ok
    else
      render json: { status: "error", msg: "Estado no actualizado" }, status: :unprocessable_entity
    end
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:active)
  end
end
