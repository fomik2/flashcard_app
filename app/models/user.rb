class User < ActiveRecord::Base
  has_many :cards
  has_many :categories
  authenticates_with_sorcery!
  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  def set_current_category(current_category)
    update_attribute('current_category_id', current_category)
  end

end
