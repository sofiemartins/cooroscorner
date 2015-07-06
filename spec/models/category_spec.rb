require 'rails_helper'

RSpec.describe Category, type: :model do
   describe "when creating a new category" do
    it "label needs to be present" do
      category = Category.new(:label => "", :abbreviation => "abbrev")
      assert !category.valid?
      assert !category.save
    end
 
    it "label has to be maximum 50 signs" do
      category = Category.new(:label => "a"*51, :abbreviation => "abbrev")
      assert !category.valid?
      assert !category.save
      category = Category.new(:label => "a"*50, :abbreviation => "abbrev")
      assert category.valid?
      assert category.save
    end

    it "label needs to be unique" do
      category = Category.new(:label => "label", :abbreviation => "abbreva")
      assert category.valid?
      assert category.save
      category = Category.new(:label => "label", :abbreviation => "abbrevb")
      assert !category.valid?
      assert !category.save
    end

    it "abbreviation needs to be present" do
      category = Category.new(:label => "label", :abbreviation => "")
      assert !category.valid?
      assert !category.save
      category = Category.new(:label => "label")
      assert !category.valid?
      assert !category.save
    end

    it "abbreviation needs to be maximum 10 signs" do
      category = Category.new(:label => "label", :abbreviation => "a"*11)
      assert !category.valid?
      assert !category.save
      category = Category.new(:label => "label", :abbreviation => "a"*10)
      assert category.valid?
      assert category.save
    end

    it "abbreviation needs to be unique" do
      category = Category.new(:label => "label1", :abbreviation => "abbrev")
      assert category.valid?
      assert category.save
      category = Category.new(:label => "label2", :abbreviation => "abbrev")
      assert !category.valid?
      assert !category.save
    end

    it "abbreviation needs to have no spaces" do
      category = Category.new(:label => "label", :abbreviation => "spa ce")
      assert !category.valid?
      assert !category.save
    end
  end
end
