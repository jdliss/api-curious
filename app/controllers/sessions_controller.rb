class SessionsController < ApplicationController
  def new
  end

  def create
    @user = request.env['omniauth.auth']['info']
    session[:user] = @user
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
