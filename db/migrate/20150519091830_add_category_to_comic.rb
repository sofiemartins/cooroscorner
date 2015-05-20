class AddCategoryToComic < ActiveRecord::Migration
  def change
    add_column :comics, :category, :string
    add_column :comics, :comic, :string
  end
end
