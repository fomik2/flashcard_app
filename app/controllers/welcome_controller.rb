class WelcomeController < ApplicationController
  skip_before_action :require_login, only: :logged_or_not

  def index
    if params[:card_id]
      @card = current_user.cards.find(params[:card_id])
    else
      @card = current_user.pending_cards
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
