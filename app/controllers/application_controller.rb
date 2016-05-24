class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user,
                :current_user_name

  def current_user
    @user ||= session[:user] if session[:user]
  end

  def current_user_name
    current_user["name"]
  end
end
