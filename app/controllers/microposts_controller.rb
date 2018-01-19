class MicropostsController < ApplicationController
  before_action :signed_in_user, only: %i[create destroy]
  before_action :correct_user_or_admin, only: :destroy

  def index; end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Post created'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    begin
      @micropost.destroy
      flash[:success] = 'Post deleted'
      redirect_to root_url
    rescue TypeError
      flash[:danger] = 'Delete error'
      redirect_to root_url
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user_or_admin
    @micropost = current_user.microposts.find_by(id: params[:id])
    @micropost = Micropost.find_by(id: params[:id]) if current_user.admin?
    redirect_to root_url if @micropost.nil? && !current_user.admin?
  end
end
