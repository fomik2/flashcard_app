require 'secretkeymanager' #модуль для выгрузки паролей из yml-файлы
class Card < ActiveRecord::Base
  
  
  belongs_to :user
  belongs_to :category
  
  has_attached_file :picture, styles: { medium: "360x360>", thumb: "100x100>" },
    default_url: "http://s3.amazonaws.com/#{ SecretKeyManager.config('aws')['bucket'] }/missing_:style.png",
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

  def check_translation(translation, timer)
    @timer = timer.to_i
    case Levenshtein.distance(translation, translated_text)
    when 0
      prepare_supermemo_object_when_translation_true(@timer)
      :success
    when 1, 2
      increment(:number_of_misprint)
      save
      :misprint
    else
      prepare_supermemo_object_when_translation_false(@timer)
      :fail
    end
  end
  
  def prepare_supermemo_object_when_translation_true(timer)
    @super_memo_object = SuperMemo.new(number_of_right, number_of_misprint, interval, efactor, timer, true)
    change_supermemo_attributes(true)
  end
 
  def prepare_supermemo_object_when_translation_false(timer)
    @super_memo_object = SuperMemo.new(number_of_right, number_of_misprint, interval, efactor, timer, false)
    change_supermemo_attributes(false)
  end

  def change_supermemo_attributes(translation_status)
    case translation_status 
    when true
      increment(:number_of_right)
      update_attributes(number_of_misprint: 0)
    when false 
      update_attributes(number_of_right: 0, number_of_misprint: 0)
    end
    increment(:number_of_review)
    update_attributes( interval: @super_memo_object.interval,
                       efactor: @super_memo_object.efactor )
    update_review_date
  end

  def update_review_date
    days = case interval
    when 0
      Date.today
    when 1
      Date.tomorrow
    else
      review_date + interval
    end
    update_attributes(review_date: days)
  end
  
end
