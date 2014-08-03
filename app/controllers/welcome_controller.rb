class WelcomeController < ApplicationController
  
  def index
    @card = Card.review_before(Date.today)
  end
end
