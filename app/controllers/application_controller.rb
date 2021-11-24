class ApplicationController < ActionController::API
  protected

  def current_user
    return unless session[:user_id]
    current_user ||= User.find(session[:user_id])
  end
  def logged_in?
    # byebug
    render status: :unauthorized unless !!session[:user_id]
  end
end
