class RemoveUsernameFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :username, :string
  end
end
