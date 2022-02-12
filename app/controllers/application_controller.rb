class ApplicationController < ActionController::API
  protected

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in? = !!session[:user_id]

  def filter_authenticated
    render status: :unauthorized unless logged_in?
  end

  def filter_admin
    render status: :forbidden unless current_user.admin?
  end
end
