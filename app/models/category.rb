class Category < ActiveRecord::Base
  validates :name, :about, presence: true
  has_one :card
end
