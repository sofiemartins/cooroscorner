class RemoveShortFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :short, :string
  end
end
