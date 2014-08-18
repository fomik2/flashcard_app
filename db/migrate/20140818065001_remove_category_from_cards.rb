class RemoveCategoryFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :category, :string
  end
end
