class AddComicIndexToComment < ActiveRecord::Migration
  def change
    add_column :comments, :comic_index, :string
  end
end
