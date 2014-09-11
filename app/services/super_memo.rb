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
      calculate_attributes_when_translation_is_correct
    else
     
      # Обнуление интервала и уменьшение фактора эффективности на 0.5 при неправильном переводе карточки
      # для уменьшения промежутка между просмотрами
      @interval = 0
      @efactor = efactor - 0.5
      constraint_attributes
    end
  end

private

  def calculate_attributes_when_translation_is_correct
    @quality = calculate_quality
    
    # вычисление коэффициента эффективности и интервала между просмотрами для карточки
    @efactor = (efactor + (0.1 -(5 - @quality) * (0.08 + (5 - @quality) * 0.02))).round(1)
    @interval = calculate_interval
    constraint_attributes
  end
  
  def calculate_quality

    # Если случилась опечатка, то качество ответа присваивается двойке
    if @number_of_misprint > 0
      @quality = 2
    else
    
    # Если перевод корректен, то качество ответа зависит от таймера (от скорости дачи ответа) 
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

  # Интервал между просмотрами зависит от количества правильных ответов, которые были даны,
  # коэффициента эффективности.
  @interval = case @number_of_right
              when 0
                1
              when 1
                2
              when 2
                6
              else
                @interval * (@number_of_right - 1) * @efactor
              end
  end

  #ограничения для значений коэффициентов
  def constraint_attributes
    @interval = @interval > 45 ? 45 : @interval
    @efactor = @efactor < 1.3 ? 1.3 : @efactor
  end
end