class CardsController < ApplicationController
  
  def new
    @card = Card.new #добавили, чтобы при отображении вьюхи new @cards не был nil 
  end                 #и не вылетало ошибки на if @cards.errors.any
  
  def index
   @cards = Card.all
  end
  
  def create
   @card = Card.new(card_params) #создаем запись из тех параметров, которые разрешили передавать
   if @card.save #сохраняем запись в базу
     redirect_to @card #идем в представление show
   else
    render 'new' #если не сработало, то перегружаем представление
   end 
  end

  def show
    @card = Card.find(params[:id]) #ищем в базе запись по id и выводим в представлении show
  end

  def edit
    @card = Card.find(params[:id])
  end
  
  def update
    @card = Card.find(params[:id])
    if @card.update(cards_params)
      redirect_to @cards
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
  
  def card_params #определяем те параметры, которые можно передавать в метод контроллера create
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end 
end
