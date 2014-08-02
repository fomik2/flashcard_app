class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true

  def check_translation(translation)
    translation == translated_text
  end

  def update_review_date(card)
    card.update(review_date: Date.today + 3)
  end
end
