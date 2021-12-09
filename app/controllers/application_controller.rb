class ApplicationController < ActionController::API
  protected

  def current_user
    return unless session[:user_id]
    User.find(session[:user_id])
  end

  def logged_in?
    session[:user_id] ? true : false
  end

  def filter_unauthenticated
    render status: :unauthorized unless logged_in?
  end

  def admin?
    render status: :forbidden unless current_user.admin?
  end
end
