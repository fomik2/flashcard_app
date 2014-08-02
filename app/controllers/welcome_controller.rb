class WelcomeController < ApplicationController
  
  def index
    @card = Card.where("review_date < ?", Date.today).first
  end
end
