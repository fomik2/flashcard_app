class User < ActiveRecord::Base
  has_many :cards
  has_many :categories
  belongs_to :current_category, class_name: 'Category'
  
  authenticates_with_sorcery!
  
  validates :password, length: { minimum: 3 }, confirmation: true, if: :password_set? 
  validates :password_confirmation, presence: true, if: :password_set?
  validates :email, uniqueness: true

  def password_set?
    @password
  end
  
  def set_current_category(current_category_id)
    update_attribute('current_category_id', current_category_id)
  end

end
