class WelcomeController < ApplicationController
  skip_before_action :require_login, only: :logged_or_not

  def index
    if current_user.current_category
      @card = current_user.current_category.cards.review_before(Date.today).first
    end
  end

  def logged_or_not
    if logged_in?
      redirect_to welcome_path
    else
      render 'logged_or_not'
    end
  end

end
