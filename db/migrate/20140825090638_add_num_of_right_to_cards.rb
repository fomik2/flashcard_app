class AddNumOfRightToCards < ActiveRecord::Migration
  def change
    add_column :cards, :num_of_right, :integer, default: 0
  end
end
