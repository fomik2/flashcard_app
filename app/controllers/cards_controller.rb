class CardsController < ApplicationController
  # метод before_action добавляет срабатывание метода find_card 
  before_action :find_card, except: [:new, :create, :index]
  
  def new
    # добавили, чтобы при отображении вьюхи new @cards не был nil 
    # и не вылетало ошибки на if @cards.errors.any
    @card = Card.new 
  end                 
  
  def index
   @cards = Card.all
  end
  
  def create
   # создаем запись из тех параметров, которые разрешили передавать
   @card = Card.new(card_params) 
   # сохраняем запись в базу
   if @card.save 
     # идем в представление show
     redirect_to @card 
   else
    # если не сработало, то перегружаем представление
    render 'new' 
   end 
  end
  
  # ищем в базе запись по id и выводим в представлении show
  def show 
  end

  def edit
  end
  
  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path 
  end

  def review
    # проверка на совпадение методом из модели
    if @card.check_translation(params[:translated_text])
      @card.update_review_date
      flash[:success] = "True! Next card!"
    else
      flash[:error] = "False!"
    end
    redirect_to root_path 
  end

private
  # определяем те параметры, которые можно передавать в метод контроллера create
  def card_params 
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
  # метод для before_action
  def find_card
    @card = Card.find(params[:id])
  end 
end
