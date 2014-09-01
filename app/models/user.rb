class User < ActiveRecord::Base
  has_many :cards
  has_many :categories
  belongs_to :current_category, class_name: 'Category'
  has_many :authentications, :dependent => :destroy

  accepts_nested_attributes_for :authentications
  
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  
  validates :password, length: { minimum: 3 }, confirmation: true, if: :password_set? 
  validates :password_confirmation, presence: true, if: :password_set?
  validates :email, uniqueness: true

  def pending_cards
    if current_category
      current_category.cards.review_before(Date.today).first
    else
      cards.review_before(Date.today).first
    end
  end

  def password_set?
    @password
  end
  
  def set_current_category(current_category_id)
    update_attribute('current_category_id', current_category_id)
  end

end
