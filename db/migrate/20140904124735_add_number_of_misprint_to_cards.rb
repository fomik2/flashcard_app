class AddNumberOfMisprintToCards < ActiveRecord::Migration
  def change
    add_column :cards, :number_of_misprint, :integer, default: 0
  end
end
