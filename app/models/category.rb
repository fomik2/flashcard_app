class Category < ActiveRecord::Base
  validates :name, :about, :user_id, presence: true
  has_many :cards
  belongs_to :user
  before_create :set_default_params

private
  
  def set_default_params
    self.name = name.capitalize
    self.about = about.capitalize
  end

end
