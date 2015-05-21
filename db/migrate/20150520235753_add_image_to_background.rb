class AddImageToBackground < ActiveRecord::Migration
  def change
    add_column :backgrounds, :image, :string
  end
end
