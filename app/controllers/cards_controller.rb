class CardsController < ApplicationController
  # метод before_action добавляет срабатывание метода find_card 
  before_action :find_card, except: [:new, :create, :index]
  
  def new
    # добавили, чтобы при отображении вьюхи new @cards не был nil 
    # и не вылетало ошибки на if @cards.errors.any
    @card = current_user.cards.new
  end
  
  def index
   @cards = current_user.cards.all
  end
  
  def create
   # создаем запись из тех параметров, которые разрешили передавать
   @card = current_user.cards.new(card_params) 
   # сохраняем запись в базу
   if @card.save
     # идем в представление show
     redirect_to user_card_path(current_user, @card)
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
      redirect_to user_card_path(current_user, @card)
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to user_cards_path 
  end

  def review
    @card.check_translation(params[:translated_text], params[:timer_value])
    @result = @card.levenshtein_check(params[:translated_text])
    if @result == :success
      flash[:translation_status] = 'true'
      redirect_to welcome_path
    elsif @result == :misprint
      flash[:misprint] = "Опечатка. Вы написали #{params[:translated_text]}, а надо #{@card.translated_text}"
      redirect_to welcome_path(card_id: @card)
    else
      flash[:translation_status] = 'false'
      redirect_to welcome_path
    end
end

private
  # определяем те параметры, которые можно передавать в метод контроллера create
  def card_params 
    params.require(:card).permit(:original_text, :translated_text, :review_date, :picture, :category_id)
  end
  # метод для before_action
  def find_card
    @card = current_user.cards.find(params[:id])
  end 
end
