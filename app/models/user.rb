class User < ActiveRecord::Base
  has_many :cards
  has_many :categories
  authenticates_with_sorcery!
  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
end
