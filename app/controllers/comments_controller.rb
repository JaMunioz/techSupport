class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @user_id = params[:user_id]
    @ticket_id = params[:ticket_id]
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.update(date_comment: DateTime.now)
    a = params[:comment][:user_id]
    @user_id = a.to_i
    b = params[:comment][:ticket_id]
    @ticket_id = b.to_i
    #respond_to do |format|
    if @comment.save
      flash[:notice] = "Your comment was created successfully"
      redirect_to ticket_path(@ticket_id, user_id:@user_id)
    else
      flash[:notice] = "Your comment could not be created, fill in all the blanks"
      redirect_back(fallback_location: root_path)
    end
    #end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.fetch(:comment, {}).permit(:comment, :date_comment, :user_id, :ticket_id)
      #params.fetch(:user_id, {})
      #params.fetch(:ticket_id, {})
    end
end
