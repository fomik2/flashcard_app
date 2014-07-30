class CardsController < ApplicationController
  
  def index
   @cards = Card.all
  end
  
  def create
  end

  def show
  end

end
