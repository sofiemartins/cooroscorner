class AddBackgroundToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :background, :string
  end
end
