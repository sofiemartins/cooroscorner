class AddAbbreviationToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :abbreviation, :string
  end
end
