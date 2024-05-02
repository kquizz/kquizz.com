class ApplicationController < ActionController::Base
  # before_action :require_login
  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      flash.keep(:error)
      redirect_to root_path # or whatever your login route is
    end
  end
end
