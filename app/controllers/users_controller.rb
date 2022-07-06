class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :index
  before_action :authenticate_user!

  def set
    $id = params[:user_id]
    redirect_to(users_path)
  end

  # GET /users or /users.json
  def index
    if !user_signed_in?
      authenticate_user!
    end
    $backer = 0
    @current_user = current_user
    #@users = User.all
    @users_roles = User.where(id: @current_user.id).pluck(:role).first
    #@current_user = User.where(id: $id).first
    if @users_roles == "user"
      @registered = User.where(role:"user")
      @tickets_open = Ticket.joins(requests: :user).where(status: ["Sended","Pending","Asked"]).where(user:{id: @current_user.id}).distinct
      @tickets_closed = Ticket.joins(requests: :user).where(status: "Closed").where(user:{id: @current_user.id}).distinct
    else
      if @users_roles == "executive"
        @executives = User.where(role:"executive")
        @tickets_open = Ticket.joins(executive_assigneds: :user).where(status: ["Sended","Pending","Asked"]).where(user:{id: @current_user.id}).distinct
        @tickets_closed = Ticket.joins(executive_assigneds: :user).where(status: "Closed").where(user:{id: @current_user.id}).distinct
      else
        @supervisors = User.where(role:"supervisor")
        @tickets_open = Ticket.joins(:requests).where(status: ["Sended","Pending","Asked"]).distinct
        @tickets_closed = Ticket.joins(:requests).where(status: "Closed").distinct
        @executive = User.where(role: "executive")
        @executive_average = ExecutiveReport.joins(:user).group(:user_id).average(:calification)
        @tickets_priority = Ticket.joins(:executive_assigneds).where(priority:nil)
        @tickets_executive_priority = (Ticket.joins(:requests).all - Ticket.joins(:executive_assigneds)).uniq
        @users_executive = User.where(role: ["user", "executive", "supervisor"])
        @overdue_tickets = Ticket.where(tags: "red").where(status:["Sended","Pending","Asked"]).order("ticket_deadline DESC")
        @admins = User.where(role:"admin")
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def statusUpdater
    if params[:order] == "reOpen" || params[:order] == "denied"
      @ticket = Ticket.find_by(id: params[:ticket_id])
      @ticket.update(status: "Pending", priority: nil, ticket_deadline: nil)
      if params[:order] == "reOpen"
      flash[:notice] = "Your ticket was opened successfully"
      end
      if params[:order] == "denied"
        flash[:notice] = "The response was denied successfully"
      end
    end
    redirect_to users_path(params[:user_id])
  end

  def changeStatus
    @user = User.find_by(id: params[:user_id])
    if params[:role] == "user" and params[:new_role] == "Upgrade"
      @tickets_of_user = Ticket.joins(requests: :user).where(requests: {user_id: @user.id}).where(status: ["Sended", "Pending", "Asked"]).distinct
      @tickets_of_user.each do |ticket|
        ticket.destroy
      end
      @user.update(role: "executive")
    elsif params[:role] == "executive" and params[:new_role] == "Upgrade"
      @executive_id = User.where(role:"executive").pluck(:id)
      @assigned = ExecutiveAssigned.joins(:ticket).where(user_id: @user.id).where(tickets: {status:["Asked", "Pending", "Sended"]})
      if @executive_id.count() > 1
        @executive_id.delete(@user.id)
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
        @order.delete([@user.id, @assigned.count()])
        @order = @order.sort {|a,b| a[1]<=>b[1]}
        @assigned.each do |a|
          a.update(user_id: @order[0][0], date_ticket_assigned: DateTime.now)
        end
      else
        @ticket = Ticket.joins(:executive_assigneds).where(executive_assigneds: {user_id:@user.id}).where(status: ["Asked", "Pending", "Sended"])
        @ticket.each do |a|
          a.update(priority:nil, status:"Sended", ticket_deadline:"", tags:"")
        end
        @assigned.each do |a|
          a.destroy
        end
      end
      @user.update(role: "supervisor")
    elsif params[:role] == "executive" and params[:new_role] == "Degrade"
      @executive_id = User.where(role:"executive").pluck(:id)
      @assigned = ExecutiveAssigned.joins(:ticket).where(user_id: @user.id).where(tickets: {status:["Asked", "Pending", "Sended"]})
      if @executive_id.count() > 1
        @executive_id.delete(@user.id)
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
        @order.delete([@user.id, @assigned.count()])
        @order = @order.sort {|a,b| a[1]<=>b[1]}
        @assigned.each do |a|
          a.update(user_id: @order[0][0], date_ticket_assigned: DateTime.now)
        end
      else
        @ticket = Ticket.joins(:executive_assigneds).where(executive_assigneds: {user_id:@user.id}).where(status: ["Asked", "Pending", "Sended"])
        @ticket.each do |a|
          a.update(priority:nil, status:"Sended", ticket_deadline:"", tags:"")
        end
        @assigned.each do |a|
          a.destroy
        end
      end
      @user.update(role: "user")
    elsif params[:role] == "supervisor" and params[:new_role] == "Degrade"
      @user.update(role: "executive")
    end
    flash[:notice] = "User updated successfully"
    redirect_to users_path
  end


  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {}).permit(:first_name, :last_name, :email, :telephone, :role)
    end
end
