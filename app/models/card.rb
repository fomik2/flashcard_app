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
  
  scope :review_before, ->(date) { where("review_date < ?", date).order('RANDOM()') }
  
  def check_translation(translation)
    translation == translated_text
  end

  def update_review_date
    update_attributes(review_date: Date.today + 3)
  end
end
