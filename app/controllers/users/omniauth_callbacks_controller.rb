class Users::OmniauthCallbacksController < ApplicationController
  def vkontakte
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in(@user)
      flash.now[:success] = 'You authorized across VK'
    else
      redirect_to root_path
      flash.now[:danger] = 'Undefined error'
    end
  end

  def failure
    redirect_to root_path
    flash.now[:danger] = 'Undefined error'
  end
end
