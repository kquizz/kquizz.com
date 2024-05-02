# app/controllers/user_sessions_controller.rb
class UserSessionsController < ApplicationController
  # skip_before_action :require_login, only: [:new, :create]

    def new
    session[:return_to] ||= request.referer
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      session[:user_id] = @user.id
      flash[:notice] = 'Login successful'
      redirect_to session.delete(:return_to) || root_path
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end



  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end
end