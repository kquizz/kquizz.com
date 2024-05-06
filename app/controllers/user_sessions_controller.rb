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
      render partial: 'user_sessions/login&signup'
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def login_signup
    render partial: 'user_sessions/login&signup'
  end

  
  def login_partial
    render partial: 'user_sessions/form'
  end

  def signup_partial
    @user = User.new 
    render partial: 'users/form', locals: { user: @user }
  end

  def destroy
    logout
    flash[:notice] = 'Login successful'
    render partial: 'user_sessions/login&signup'
  end
end