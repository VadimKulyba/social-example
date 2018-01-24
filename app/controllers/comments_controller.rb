class CommentsController < ApplicationController
  before_action :signed_in_user, only: %i[create destroy]
  before_action :correct_user_or_admin, only: :destroy

  def index; end

  def create
    @comment = current_user.comments.build(comment_params)
    p @comment
    if @comment.save
      flash[:success] = 'Comment created'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    begin
      @comment.destroy
      flash[:success] = 'Comment deleted'
      redirect_to current_user
    rescue TypeError
      flash[:danger] = 'Delete error'
      redirect_to current_user
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :micropost_id)
  end

  def correct_user_or_admin
    @comment = current_user.comments.find_by(id: params[:id])
    @comment = Comment.find_by(id: params[:id]) if current_user.admin?
    redirect_to root_url if @comment.nil? && !current_user.admin?
  end
end
