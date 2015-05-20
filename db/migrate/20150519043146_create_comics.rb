class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.string :authors_comment

      t.timestamps null: false
    end
  end
end
