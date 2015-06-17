class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.text :authors_comment

      t.timestamps null: false
    end
  end
end
