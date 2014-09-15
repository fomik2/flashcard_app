class UserSessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def logged_or_not
    if logged_in?
      redirect_to home_path
    else
      render 'logged_or_not'
    end
  end

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to home_path, notice: "Login successful"
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_path, notice: 'Logged out'
  end
end
