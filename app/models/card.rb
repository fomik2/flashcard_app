class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true

  def check_translation(translate)
    translate == translated_text
  end
end
