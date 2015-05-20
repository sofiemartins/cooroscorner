class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :label
      t.string :short

      t.timestamps null: false
    end
  end
end
