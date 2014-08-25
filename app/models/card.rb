class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  has_attached_file :picture, styles: { medium: "360x360>", thumb: "100x100>" }, 
    default_url: 'https://s3.amazonaws.com/my_rails_app/missing_:style.png',
    storage: :s3,
    s3_credentials: S3_CREDENTIALS
  
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :picture, less_than: 2.megabytes
  validates :original_text, :translated_text, :review_date, :user_id, :category_id, presence: true
  # скоуп позволяет выделить часто использованные запросы и поместить их в метод
  
  scope :review_before, ->(date) { where("review_date <= ?", date).order('RANDOM()') }
  before_create :set_default_attributes 

  def checkTranslation(translation)
    if translation == translated_text
      update_attribute('num_of_right', num_of_right.next)
      return true
    else
      update_attribute('num_of_wrong', num_of_wrong.next)
      return false
    end
  end

  def thenTranslationTrue
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
    end
    update_attribute('num_of_wrong', 0)
    update_attributes(review_date: days) 
  end
  
  def thenTranslationFalse
    if num_of_wrong == 3
      update_attributes(num_of_right: 1, num_of_wrong: 0)
      update_attributes(review_date: Date.today.next)
    end
  end

private

  def set_default_attributes
    self.num_of_wrong = 0
    self.num_of_right = 0
  end

end
