class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true

  def check_translate(user_translate)
    user_translate == translated_text
  end
end
