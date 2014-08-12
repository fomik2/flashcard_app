class WelcomeController < ApplicationController
  
  def index
    @card = Card.review_before(Date.today, current_user).first
  end
end
