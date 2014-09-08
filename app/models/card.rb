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
    levenshtein_check_result = levenshtein_check(translation)
    case levenshtein_check_result
    when :success
      update_review_attributes(@timer, true)
    when :misprint
      increment(:number_of_misprint)
      save
    when :fail
      update_review_attributes(@timer, false)
    end
    return levenshtein_check_result
  end
  
  def update_review_attributes(timer, translation_succeed)
    supermemo = SuperMemo.new(number_of_right, number_of_misprint, interval, efactor, timer, translation_succeed)  
    review_attributes = { interval: supermemo.interval,
                          efactor: supermemo.efactor,
                          number_of_review: number_of_review + 1 
                        }
    if translation_succeed
      review_attributes.update(number_of_misprint: 0, number_of_right: number_of_right + 1)
      update_attributes(review_date: Date.today + supermemo.interval)
    else
      review_attributes.update(number_of_right: 0, number_of_misprint: 0, review_date: Date.today)     
    end
    update_attributes(review_attributes)
  end

private

def levenshtein_check(translation)
    case Levenshtein.distance(translation, translated_text)
    when 0
      :success
    when 1, 2
      :misprint
    else
      :fail
    end
  end

end
