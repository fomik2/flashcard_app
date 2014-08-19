class AddActivateToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :activate, :boolean
  end
end
