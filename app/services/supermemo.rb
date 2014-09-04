class SuperMemo
  
  attr_accessor :interval, :quality, :efactor
  
  def initialize(number_of_right, number_of_misprint, interval, efactor, opts_param)
    @quality = 0
    @interval = interval
    @efactor = efactor
    if opts_param == 'fail'
      calculate_attrubutes_when_answer_false
    else
     calculate_attributes_when_answer_true(number_of_right, number_of_misprint, opts_param) 
    end
  end
  
  def calculate_attrubutes_when_answer_false
    @quality = 0
    @interval = 0
    @efactor = efactor-0.5
  end

  def calculate_attributes_when_answer_true(number_of_right, number_of_misprint, opts_param)
    if number_of_misprint > 0
      @quality = 2
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
    end
    @efactor = (efactor+(0.1-(5-@quality)*(0.08+(5-@quality)*0.02))).round(1)
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
    constraint_attributes
  end

  def constraint_attributes
    if @interval > 45
        @interval = 45
      end
      if @efactor < 1.3
        @interval = 1.3
      end
  end
end