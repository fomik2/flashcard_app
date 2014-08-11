class WelcomeController < ApplicationController
  
  def index
    @card = Card.review_before(Date.today, current_user.id).first
  end
end
