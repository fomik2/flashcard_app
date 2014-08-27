require 'fcmanageraws' #модуль для динамической загрузки названия bucket-а S3
class Card < ActiveRecord::Base
  
  
  belongs_to :user
  belongs_to :category
  
  has_attached_file :picture, styles: { medium: "360x360>", thumb: "100x100>" },
    default_url: "http://s3.amazonaws.com/#{FCManagerAWS.config['bucket']}/missing_:style.png",
    storage: :s3,
    s3_credentials: S3_CREDENTIALS
  
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :picture, less_than: 2.megabytes
  validates :original_text, 
            :translated_text, 
            :review_date, 
            :user_id, 
            :category_id, presence: true
            
  # скоуп позволяет выделить часто использованные запросы и поместить их в метод
  scope :review_before, ->(date) { where("review_date <= ?", date).order('RANDOM()') }
  
  def check_translation(translation)
    if translation == translated_text
      increase_correct_answer_counter
      return true
    else
      increase_incorrect_answer_counter
      return false
    end
  end

  def update_review_date
    case num_of_right
    when 0
      days = Date.today
    when 1
      days = Date.today + 1.day
    when 2
      days = Date.today + 3.days
    when 3
      days = Date.today + 7.days
    when 4
      days = Date.today + 14.days
    when 5
      days = Date.today.next_month
    else
      days = review_date.next_month + num_of_right
    end
    update_attributes(review_date: days)
  end

  def increase_correct_answer_counter
    increment(:num_of_right)
    update_review_date
  end
  
  def increase_incorrect_answer_counter
    increment(:num_of_wrong)
    if num_of_wrong >= 3
      update_attributes(num_of_right: 0, num_of_wrong: 0)                                   
    end
    update_review_date
  end

  def advanced_update_review_date
    update_attributes(review_date: review_date.next_month + num_of_right)  
  end

end
