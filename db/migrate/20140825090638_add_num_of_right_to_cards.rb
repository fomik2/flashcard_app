class AddNumOfRightToCards < ActiveRecord::Migration
  def change
    add_column :cards, :num_of_right, :integer
  end
end
