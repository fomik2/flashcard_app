class AddCurrentCatIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_category_id, :integer
  end
end
