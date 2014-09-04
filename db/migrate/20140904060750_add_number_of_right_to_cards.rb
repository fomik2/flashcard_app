class AddNumberOfRightToCards < ActiveRecord::Migration
  def change
    add_column :cards, :number_of_right, :integer, default: 0
  end
end
