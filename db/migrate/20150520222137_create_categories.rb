class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :label, :unique => true
      t.string :short, :unique => true

      t.timestamps null: false
    end
  end
end
