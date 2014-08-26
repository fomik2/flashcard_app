class Card < ActiveRecord::Base
  #модуль для динамической загрузки названия bucket-а S3
  require 'fcmanageraws'
  
  belongs_to :user
  belongs_to :category
  
  has_attached_file :picture, styles: { medium: "360x360>", thumb: "100x100>" },
    default_url: "http://s3.amazonaws.com/#{FCManagerAWS.config['bucket']}/missing_:style.png",
    storage: :s3,
    s3_credentials: S3_CREDENTIALS
  
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :picture, less_than: 2.megabytes
  validates :original_text, :translated_text, :review_date, :user_id, 
    :category_id, presence: true
  
  # скоуп позволяет выделить часто использованные запросы и поместить их в метод
  scope :review_before, ->(date) { where("review_date <= ?", date).order('RANDOM()') }
  
  def check_translation(translation)
    if translation == translated_text
      update_attributes(num_of_right: num_of_right.next)
      increase_correct_answer_counter
      return true
    else
      update_attributes(num_of_wrong: num_of_wrong.next)
      increase_incorrect_answer_counter
      return false
    end
  end

  def increase_correct_answer_counter
    days = Date.today
    case num_of_right
      when 0
        days = Date.today
      when 1
        days = days.next_day
      when 2
        days = Date.today + 3
      when 3
        days = Date.today + 7
      when 4
        days = Date.today + 14
      when 5
        days = days.next_month
      else
        update_review_date(review_date, num_of_right)
        return 
    end
    update_attributes(num_of_wrong: 0, review_date: days)
  end
  
  def increase_incorrect_answer_counter
    if num_of_wrong == 3
      update_attributes(num_of_right: 1, num_of_wrong: 0)
      increase_correct_answer_counter
    end
  end

  def update_review_date(review_date, num_of_right)
    update_attributes(review_date: review_date.next_month + num_of_right)  
  end

end
