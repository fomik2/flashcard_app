class AddNumberOfReviewToCards < ActiveRecord::Migration
  def change
    add_column :cards, :number_of_review, :integer, default: 0
  end
end
