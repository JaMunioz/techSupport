class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]

  # GET /responses or /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1 or /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
    @user_id = params[:user_id]
    @ticket_id = params[:ticket_id]
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    @response = Response.new(response_params)
    @response.update(date_response: DateTime.now)
    a = params[:response][:user_id]
    @user_id = a.to_i
    b = params[:response][:ticket_id]
    @ticket_id = b.to_i
    @ticket = Ticket.find_by(id:@ticket_id)
    #respond_to do |format|
    if @response.save
      @ticket.update(status: "Asked")
      flash[:notice] = "Your response was created successfully"
      redirect_to ticket_path(@ticket_id, user_id:@user_id)
    else
      flash[:notice] = "Your response could not be created, fill in all the blanks"
      redirect_back(fallback_location: root_path)
    end
    #end
  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to response_url(@response), notice: "Response was successfully updated." }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url, notice: "Response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.fetch(:response, {}).permit(:response, :date_response, :user_id, :ticket_id)
    end
end
