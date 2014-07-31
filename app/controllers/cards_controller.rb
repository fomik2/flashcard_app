class CardsController < ApplicationController
  
  def new
    #добавили, чтобы при отображении вьюхи new @cards не был nil 
    #и не вылетало ошибки на if @cards.errors.any
    @card = Card.new 
  end                 
  
  def index
   @cards = Card.all
  end
  
  def create
   #создаем запись из тех параметров, которые разрешили передавать
   @card = Card.new(card_params) 
   #сохраняем запись в базу
   if @card.save 
     #идем в представление show
     redirect_to @card 
   else
    #если не сработало, то перегружаем представление
    render 'new' 
   end 
  end

  def show
    #ищем в базе запись по id и выводим в представлении show
    @card = Card.find(params[:id]) 
  end

  def edit
    @card = Card.find(params[:id])
  end
  
  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path 
  end

private
  #определяем те параметры, которые можно передавать в метод контроллера create
  def card_params 
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end 
end
