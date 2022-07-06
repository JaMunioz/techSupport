class API::V1::TicketsController < APIController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all

    #@tickets_open = Ticket.where(status: ["Sended","Pending","Asked"])
    #@tickets_open = Ticket.joins(requests: :user).where(status: ["Sended","Pending","Asked"]).where(user:{id: @current_user.id}).distinct
    #@tickets_closed = Ticket.where(status: "Closed")
    #@tickets_closed = Ticket.joins(requests: :user).where(status: "Closed").where(user:{id: @current_user.id}).distinct
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  #def all_tickets_by_user
  #  @tickets = Ticket.where(user_id: params[:user_id])
  #end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      render :show, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    if @ticket.update(ticket_params)
      render :show, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    render :show, status: :created, location: @ticket
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.fetch(:ticket, {}).permit(:id, :date_incident, :title, :description)
  end
end
