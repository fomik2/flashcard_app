class Card < ActiveRecord::Base
  belongs_to :user
  validates :original_text, :translated_text, :review_date, presence: true
  # скоуп позволяет выделить часто использованные запросы и поместить их в метод
  scope :review_before, ->(date) { where("review_date < ?", date).order('RANDOM()') }
  
  def check_translation(translation)
    translation == translated_text
  end

  def update_review_date
    update_attributes(review_date: Date.today + 3)
  end
end
