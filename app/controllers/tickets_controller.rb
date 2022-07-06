class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def set
    $id_ticket = params[:ticket_id]
    $id_user = params[:user_id]
    $backer = params[:backer]
    if $backer == "direct"
      redirect_to("/tickets/" + $id_ticket+"/edit")
    else
      redirect_to("/tickets/" + $id_ticket)
    end
  end

  def index
    @tickets = Ticket.all
    @tickets_open = Ticket.joins(requests: :user).where(status: ["Sended", "Pending", "Asked"]).where(user: { id: @current_user.id }).distinct
    @tickets_closed = Ticket.joins(requests: :user).where(status: "Closed").where(user: { id: @current_user.id }).distinct
  end

  def show
    $backer = nil
    @ticket_id = $id_ticket
    @user_id = $id_user
    @current_user = current_user
    @users_roles = User.where(id: @current_user.id).pluck(:role).first
    @user_ticket = User.joins(requests: :ticket).where(tickets: { id: @ticket.id }).distinct
    @executive_ticket = User.joins(executive_assigneds: :ticket).where(tickets: { id: @ticket.id }).distinct
    @comments = @ticket.comments
    @responses = @ticket.responses
    @last_response = @ticket.responses.last
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @user_id = params[:user_id]
    @current_user = User.where(id: @user_id).first
  end

  # GET /tickets/1/edit
  def edit
    @current_user = current_user
    @priority = ["Urgent", "High", "Normal", "Low"]
    @status = ["Asked", "Sended", "Pending", "Closed"]
    @tickets_priority = Ticket.joins(:executive_assigneds).where(priority: nil)
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    a = params[:ticket][:userid]
    @user_id = a.to_i
    b = params[:ticket][:user_id]
    @ticket_for_user = b.to_i
    #respond_to do |format|
    if @ticket.save
      @ticket.flyer.attach(params[:ticket][:flyer])
      if @ticket_for_user == 0
        @request = Request.create(ticket_id: @ticket.id, user_id: @user_id)
        @ticket.update(incident_creation_date: DateTime.now)
        @executive_id = User.where(role:"executive").pluck(:id)
        @hash = ExecutiveAssigned.joins(:ticket).where(tickets: {status: ["Asked", "Pending", "Sended"]}).group(:user_id).count()
        @order = @hash.sort {|a,b| a[1]<=>b[1]}
        @ids = []
        @order.each do |a|
          @ids.push(@order[@order.find_index(a)][0].to_i)
        end
        @executive_id.each do |a|
          if !@ids.include?(a)
            @order.push([a,0])
          end
        end
        @order = @order.sort {|a,b| a[1]<=>b[1]}
        @count = @order.count()
        sum = 0
        @order.each do |a|
           sum += @order[@order.find_index(a)][1].to_i
        end
        if @count != 0
           division = sum.to_f/@count.to_f
        else
           division = nil
        end
        if division != @order[0][1] and division != nil
           @executive_assigned = ExecutiveAssigned.create(ticket_id: @ticket.id, user_id: @order[0][0], date_ticket_assigned: DateTime.now)
           @ticket.update(status: "Pending")
         end
        $id_user = @user_id
        flash[:notice] = "Your ticket was created successfully"
        redirect_to ticket_path(@ticket.id, user_id: @user_id)
      else
        @request = Request.create(ticket_id: @ticket.id, user_id: @ticket_for_user)
        @ticket.update(incident_creation_date: DateTime.now)
        @executive_id = User.where(role:"executive").pluck(:id)
        @hash = ExecutiveAssigned.joins(:ticket).where(tickets: {status: ["Asked", "Pending", "Sended"]}).group(:user_id).count()
        @order = @hash.sort {|a,b| a[1]<=>b[1]}
        @ids = []
        @order.each do |a|
          @ids.push(@order[@order.find_index(a)][0].to_i)
        end
        @executive_id.each do |a|
          if !@ids.include?(a)
            @order.push([a,0])
          end
        end
        @order = @order.sort {|a,b| a[1]<=>b[1]}
        @count = @order.count()
        sum = 0
        @order.each do |a|
          sum += @order[@order.find_index(a)][1].to_i
        end
        if @count != 0
          division = sum.to_f/@count.to_f
        else
          division = nil
        end
        if division != @order[0][1] and division != nil
          @executive_assigned = ExecutiveAssigned.create(ticket_id: @ticket.id, user_id: @order[0][0], date_ticket_assigned: DateTime.now)
          @ticket.update(status: "Pending")
        end
        flash[:notice] = "Ticket for user created successfully"
        redirect_to users_path(@user_id)
      end

      #redirect_back(fallback_location: ticket_path(@ticket.id, user_id:@user_id))
      #redirect_to ticket_path(@ticket.id, user_id:@user_id)
      $id_user = @user_id
    else
      flash[:notice] = "Your ticket could not be created, fill in all the blanks"
      redirect_back(fallback_location: root_path)
      #format.html { render :new, status: :unprocessable_entity }
      #format.json { render json: @ticket.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    a = params[:ticket][:user_id]
    @user_id = a.to_i
    @ticket_id = $id_ticket
    @executive_assigned_find = ExecutiveAssigned.find_by(ticket_id: @ticket_id)
    priority = params[:ticket][:priority]
    status = params[:ticket][:status]
    #respond_to do |format|
    if @ticket.update(ticket_params)
      if @executive_assigned_find.nil?
        @executive_assigned = ExecutiveAssigned.create(ticket_id: @ticket.id, user_id: @user_id, date_ticket_assigned: DateTime.now)
      else
        if @user_id != 0
          @executive_assigned_find.update(user_id: @user_id)
        end
      end
      if priority == "Urgent"
        @ticket.update(priority: priority, tags: "yellow", ticket_deadline: DateTime.now + 1.days)
      elsif priority == "High"
        @ticket.update(priority: priority, tags: "green", ticket_deadline: DateTime.now + 3.days)
      elsif priority == "Normal"
        @ticket.update(priority: priority, tags: "green", ticket_deadline: DateTime.now + 5.days)
      elsif priority == "Low"
        @ticket.update(priority: priority, tags: "green", ticket_deadline: DateTime.now + 7.days)
      end
      if status == "Pending"
        @ticket.update(status: status)
      elsif status == "Asked"
        @ticket.update(status: status)
      end
      flash[:notice] = "Your ticket was updated successfully"
      redirect_to ticket_path(@ticket.id, user_id: @user_id)
    else
      flash[:notice] = "Your ticket could not be updated, fill in all the blanks"
      redirect_back(fallback_location: root_path)
    end
    #end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    flash[:notice] = "Your ticket was deleted successfully"
    redirect_to users_path($id_user)
    #respond_to do |format|
    #format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
    #format.json { head :no_content }
    #end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    #params.fetch(:user_id, {})
    #params.fetch(:ticket_id, {}).permit(:id, :date_incident, :title, :description, :flyer)
    params.require(:ticket).permit(:id, :date_incident, :title, :description, :flyer, :priority, :status)
  end
end
