class SuperMemo
  
  attr_accessor :interval, :quality, :efactor
  
  def initialize(number_of_right, interval, efactor, opts_param)
    #присваиваем @quality
    if opts_param == 'fail'
      @quality = 0
      @interval = 0
      @efactor = efactor-0.5
    else
      @quality = case opts_param
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
      #вычисляем коэффициент эффективности
      @efactor = (efactor+(0.1-(5-@quality)*(0.08+(5-@quality)*0.02))).round(1)
      #вычисляем интервал
      @interval = case number_of_right
      when 0
        1
      when 1
        2
      when 2
        6
      else
        @interval = interval*(number_of_right-1)*@efactor
      end
    end
    #условия ограничения для коэффициентов
    if @interval > 45
      @interval = 45
    end
    if @efactor < 1.3
      @interval = 1.3
    end
  end

end