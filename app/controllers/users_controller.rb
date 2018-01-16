# RailsControllerUsers
class UsersController < ApplicationController
  before_action :signed_in_user, only: %i[edit update index destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.provider = 'default'
    if @user.save
      sign_in(@user) # in
      flash[:success] = 'Welcome to the App!'
      # exchange user_path on @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = ' Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      flash[:danger] = 'Please sign in.'
      redirect_to signin_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to(root_url)
      flash[:danger] = 'You dont have access to this account, please sign in'
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
