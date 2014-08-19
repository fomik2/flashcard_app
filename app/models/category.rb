class Category < ActiveRecord::Base
  validates :name, :about, :user_id, presence: true
  has_many :cards
  belongs_to :user

  def set_categories_to_true(categories)
    categories.each do |f|
      f.update_attributes(activate: false)
    end 
    update_attributes(activate: true)
  end

end
