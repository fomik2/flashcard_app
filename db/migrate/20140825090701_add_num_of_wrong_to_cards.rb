class AddNumOfWrongToCards < ActiveRecord::Migration
  def change
    add_column :cards, :num_of_wrong, :integer, default: 0
  end
end
