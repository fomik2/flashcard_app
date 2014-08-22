class Category < ActiveRecord::Base
  validates :name, :about, :user_id, presence: true
  
  has_many :cards
  belongs_to :user
  
  before_create :set_default_attributes

private
  
  def set_default_attributes
    self.name = name.capitalize
    self.about = about.capitalize
  end

end
