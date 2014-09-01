require 'secretkeymanager' #модуль для выгрузки паролей из yml-файлы
class Card < ActiveRecord::Base
  
  
  belongs_to :user
  belongs_to :category
  
  has_attached_file :picture, styles: { medium: "360x360>", thumb: "100x100>" },
    default_url: "http://s3.amazonaws.com/#{ SecretKeyManager.config('config/aws.yml')['bucket'] }/missing_:style.png",
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
    case Levenshtein.distance(translation, translated_text)
    when 0
      increase_correct_answer_counter
      :success
    when 1, 2
      :misprint
    else
      increase_incorrect_answer_counter
      :fail
    end
  end
  
  def update_review_date
    days = case num_of_right
    when 0
      Date.today
    when 1
      Date.tomorrow
    when 2
      Date.today + 3.days
    when 3
      Date.today + 7.days
    when 4
      Date.today + 14.days
    when 5
      Date.today.next_month
    else
      review_date.next_month + num_of_right
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
  
end
