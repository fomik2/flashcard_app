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

  #записывает текущую категорию в поле current_category_id
  def set_current_category
    current_user.set_current_category(params[:category_id])
    redirect_to welcome_path
  end

private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
