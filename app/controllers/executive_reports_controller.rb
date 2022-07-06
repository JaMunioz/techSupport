class ExecutiveReportsController < ApplicationController
  before_action :set_executive_report, only: %i[ show edit update destroy ]

  # GET /executive_reports or /executive_reports.json
  def index

    @executive_reports = ExecutiveReport.all
    @all = params[:options][:"{:class=>\"form-control\"}"].to_i unless params[:start_date].nil?
    if @all == 0
      @closed = Ticket.joins(executive_assigneds: :user).where(status: "Closed").where('date_ticket_assigned <= ?', params[:end_date][:"{:class=>\"form-control\"}"])
                      .where('date_ticket_assigned >= ?',params[:start_date][:"{:class=>\"form-control\"}"]).where(users: {id:params[:user_id][:email]}).count() unless params[:start_date].nil?
      @open = Ticket.joins(executive_assigneds: :user).where(status: ["Pending", "Asked"]).where('date_ticket_assigned <= ?', params[:end_date][:"{:class=>\"form-control\"}"])
                    .where('date_ticket_assigned >= ?',params[:start_date][:"{:class=>\"form-control\"}"]).where(users: {id:params[:user_id][:email]}).count() unless params[:end_date].nil?
      @average_evaluation = ExecutiveReport.where(user_id: params[:user_id][:email]).average(:calification) unless params[:user_id].nil?
      if @average_evaluation.nil?
        @average_evaluation = 0
      end
      @user = User.find_by(id: params[:user_id][:email]) unless params[:user_id].nil?
      if @user != nil
        flash[:notice] = "Report generated successfully"
      end

    else
      @ids = User.where(role:"executive").pluck(:id)
      @ids.each do |a|
        @closed = Ticket.joins(executive_assigneds: :user).where(status: "Closed").where('date_ticket_assigned <= ?', params[:end_date][:"{:class=>\"form-control\"}"])
                        .where('date_ticket_assigned >= ?', params[:start_date][:"{:class=>\"form-control\"}"]).where(users: { id: a }).count() unless params[:start_date].nil?
        @open = Ticket.joins(executive_assigneds: :user).where(status: ["Pending", "Asked"]).where('date_ticket_assigned <= ?', params[:end_date][:"{:class=>\"form-control\"}"])
                      .where('date_ticket_assigned >= ?', params[:start_date][:"{:class=>\"form-control\"}"]).where(users: { id: a }).count() unless params[:end_date].nil?
        @average_evaluation = ExecutiveReport.where(user_id: a).average(:calification) unless params[:user_id].nil?
        @user = User.find_by(id: a) unless params[:user_id].nil?
      end
      if @user != nil
        flash[:notice] = "Report generated successfully"
      end
    end
  end

  # GET /executive_reports/1 or /executive_reports/1.json
  def show
  end

  # GET /executive_reports/new
  def new
    @executive_report = ExecutiveReport.new
    @ticket_id = params[:ticket_id]
    @executive_id = params[:user_id]
    @user_id = params[:user1_id]
  end

  # GET /executive_reports/1/edit
  def edit
  end

  # POST /executive_reports or /executive_reports.json
  def create
    @executive_report = ExecutiveReport.new(executive_report_params)
    @executive_report.update(date: DateTime.now)
    a = params[:executive_report][:user1id]
    @user_id = a.to_i
    b = params[:executive_report][:ticket_id]
    @ticket_id = b.to_i
    @ticket = Ticket.find_by(id:@ticket_id)
    #respond_to do |format|
    if @executive_report.save
      @ticket.update(status: "Closed", date_ticket_resolution: DateTime.now)
      flash[:notice] = "Your report was sended successfully"
      redirect_to ticket_path(@ticket_id, user_id:@user_id)
    else
      flash[:notice] = "Your report could not be created, fill in all the blanks"
      redirect_back(fallback_location: root_path)
    end
    #end
  end

  # PATCH/PUT /executive_reports/1 or /executive_reports/1.json
  def update
    respond_to do |format|
      if @executive_report.update(executive_report_params)
        format.html { redirect_to executive_report_url(@executive_report), notice: "Executive report was successfully updated." }
        format.json { render :show, status: :ok, location: @executive_report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @executive_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /executive_reports/1 or /executive_reports/1.json
  def destroy
    @executive_report.destroy

    respond_to do |format|
      format.html { redirect_to executive_reports_url, notice: "Executive report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def statistic
    start_date, end_date = params.values_at(:start_date, :end_date)
    @start = params[:start_date]
    @end = params[:end_date]
    if start_date and end_date
      @status = true
      @created = Ticket.where('incident_creation_date <= ?',end_date)
                       .where('incident_creation_date >= ?',start_date)
      @count_created = @created.count()
      @open = @created.filter{|ticket| ["Asked", "Sended", "Pending"].include? ticket.status}.count()
      @closed = @created.filter{|ticket| ticket.status == "Closed"}.count()
      @histogram = {"Number of Tickets Created" => @count_created, "Number of Tickets Open" => @open, "Number of Tickets Closed" => @closed}
      flash[:notice] = "Your statistic was generated successfully"
    else
      @status = false
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_executive_report
      @executive_report = ExecutiveReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def executive_report_params
      params.fetch(:executive_report, {}).permit(:calification, :date, :user_id, :ticket_id)
    end
end
