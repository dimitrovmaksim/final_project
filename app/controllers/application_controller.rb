class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :check_admin
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def check_admin
    unless current_user && current_user.admin?
      redirect_to articles_path alert: "Invalid Page"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to log_in_path notice: "Please log in"
    end
  end
end

