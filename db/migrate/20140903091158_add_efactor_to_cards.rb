class AddEfactorToCards < ActiveRecord::Migration
  def change
    add_column :cards, :efactor, :float, default: 2.5
  end
end
