class API::V1:: UsersController < APIController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
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

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
      if @user.update(user_params)
        render :show, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    render :show, status: :created, location: @user

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user, {}).permit(:id,:first_name,:last_name,:email,:telephone,:role)
  end
end
