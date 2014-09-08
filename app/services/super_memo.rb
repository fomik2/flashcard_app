=begin
Сервисный объект для модели Card. Реализует метод SuperMemo, вычисляющий интервалы
между просмотрами той или иной карточки на основе коэффициентов quality и efactor.
Коэффициент quality высчитывается на основе таймера на странице с карточкой. Чем болше времени 
требуется на перевод, тем меньше коэффициент quality.
=end
class SuperMemo 
  
  attr_accessor :interval, :quality, :efactor

  def initialize(number_of_right, number_of_misprint, interval, efactor, timer, status)
    @quality = 0
    @interval = interval
    @efactor = efactor
    @number_of_misprint = number_of_misprint
    @number_of_right = number_of_right
    if status
      @timer = timer
      calculate_attributes_when_translation_true
    else
      @interval = 0
      @efactor = efactor - 0.5
    end
  end

private

  def calculate_attributes_when_translation_true
    @quality = calculate_quality
    #вычисление коэффициента эффективности и интервала между просмотрами для карточки
    @efactor = (efactor + (0.1 -(5 - @quality) * (0.08 + (5 - @quality) * 0.02))).round(1)
    @interval = calculate_interval
    constraint_attributes
  end
  
  def calculate_quality
    if @number_of_misprint > 0
      @quality = 2
    else
    @quality = case @timer
               when 0..15
                 5
               when 15..20
                 4
               when 20..30
                 3
               when 30..40
                 2 
               when 40..60
                 1
               end
    end
  end

 def calculate_interval
  @interval = case @number_of_right
                when 0
                  1
                when 1
                  2
                when 2
                  6
                else
                  @interval = @interval * (@number_of_right - 1) * @efactor
                end
  end

  #ограничения для значений коэффициентов
  def constraint_attributes
    if @interval > 45
        @interval = 45
      end
      if @efactor < 1.3
        @interval = 1.3
      end
  end
end