class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to welcome_path
    else
      render 'new'
    end
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
