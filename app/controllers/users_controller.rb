class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    	redirect_to user_welcome_path(@user)
    else
      render 'new'
    end
  end

  def index
    #Если пользователь залогинен, то открывает страницу приветствия
    if logged_in?
      @user_id = current_user.id
      redirect_to "/users/#{@user_id}/welcome/"
    end
  end

private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
