class AddImageToComic < ActiveRecord::Migration
  def change
    add_column :comics, :image, :string
  end
end
