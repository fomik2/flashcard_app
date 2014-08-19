class WelcomeController < ApplicationController
  skip_before_action :require_login, only: :logged_or_not

  def index
    if params[:format]
      current_category = current_user.categories.find(params[:format])
      @card = current_category.cards.review_before(Date.today).first
    end
    @categories = current_user.categories
  end

  def logged_or_not
    if logged_in?
      redirect_to welcome_path
    else
      render 'logged_or_not'
    end
  end

end
