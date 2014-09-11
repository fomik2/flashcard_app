class CardsController < ApplicationController
  # метод before_action добавляет срабатывание метода find_card 
  skip_before_action :require_login, only: :logged_or_not
  before_action :find_card, except: [:new, :create, :index, :home, :logged_or_not]
  
  def logged_or_not
    if logged_in?
      redirect_to home_path
    else
      render 'logged_or_not'
    end
  end

  def new
    # добавили, чтобы при отображении вьюхи new @cards не был nil 
    # и не вылетало ошибки на if @cards.errors.any
    @card = current_user.cards.new
  end
  
  def home
    if params[:card_id]
      @card = current_user.cards.find(params[:card_id])
    else
      @card = current_user.pending_cards.first
    end
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
      redirect_to user_cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to user_cards_path 
  end

  def review
    @result = @card.check_translation(params[:translated_text], params[:timer_value])
    if @result == :success
      @card = current_user.pending_cards.first
      flash[:translation_status] = 'true'
      respond_to do |format|
        format.html { redirect_to home_path }
        format.js
      end
    elsif @result == :misprint
      flash[:misprint] = "Опечатка. Вы написали #{params[:translated_text]}, а надо #{@card.translated_text}"
      respond_to do |format|
        format.html { redirect_to home_path(card_id: @card) }
        format.js
      end
    else
      flash[:translation_status] = 'false'
      respond_to do |format|
        format.html { redirect_to home_path }
        format.js
      end
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
