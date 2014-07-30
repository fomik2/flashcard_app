class CardsController < ApplicationController
  
  def new
    @cards = Card.new #добавили, чтобы при отображении вьюхи new @cards не был nil 
  end                 #и не вылетало ошибки на if @cards.errors.any
  
  def index
   @cards = Card.all
  end
  
  def create
   @cards = Card.new(cards_params) #создаем запись из тех параметров, которые разрешили передавать
   if @cards.save #сохраняем запись в базу
     redirect_to @cards #идем в представление show
   else
    render 'new' #если не сработало, то перегружаем представление
   end 
  end

  def show
    @cards = Card.find(params[:id]) #ищем в базе запись по id и выводим в представлении show
  end

  def edit
    @cards = Card.find(params[:id])
  end
  
  def update
    @cards = Card.find(params[:id])
    if @cards.update(cards_params)
      redirect_to @cards
    else
      render 'edit'
    end
  end

  def destroy
    @cards = Card.find(params[:id])
    @cards.destroy
    redirect_to cards_path 
  end

private
  
  def cards_params #определяем те параметры, которые можно передавать в метод контроллера create
    params.require(:cards).permit(:original_text, :translated_text, :review_date)
  end 
end
