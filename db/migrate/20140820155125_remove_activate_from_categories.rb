class RemoveActivateFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :activate, :boolean
  end
end
