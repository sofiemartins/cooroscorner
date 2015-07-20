class AddColorToBackground < ActiveRecord::Migration
  def change
    add_column :backgrounds, :color, :string
  end
end
