require 'rails_helper'

RSpec.describe Category, type: :model do
   describe "when creating a new category" do
    it "label needs to be present" do
      category = Category.new(:label => "", :short => "short")
      assert !category.valid?
      assert !category.save
    end
 
    it "label has to be maximum 50 signs" do
      category = Category.new(:label => "a"*51, :short => "short")
      assert !category.valid?
      assert !category.save
      category = Category.new(:label => "a"*50, :short => "short")
      assert category.valid?
      assert category.save
    end

    it "label needs to be unique" do
      category = Category.new(:label => "label", :short => "shorta")
      assert category.valid?
      assert category.save
      category = Category.new(:label => "label", :short => "shortb")
      assert !category.valid?
      assert !category.save
    end

    it "short needs to be present" do
      category = Category.new(:label => "label", :short => "")
      assert !category.valid?
      assert !category.save
      category = Category.new(:label => "label")
      assert !category.valid?
      assert !category.save
    end

    it "short needs to be maximum 10 signs" do
      category = Category.new(:label => "label", :short => "a"*11)
      assert !category.valid?
      assert !category.save
      category = Category.new(:label => "label", :short => "a"*10)
      assert category.valid?
      assert category.save
    end

    it "short needs to be unique" do
      category = Category.new(:label => "label1", :short => "short")
      assert category.valid?
      assert category.save
      category = Category.new(:label => "label2", :short => "short")
      assert !category.valid?
      assert !category.save
    end

    it "short needs to have no spaces" do
      category = Category.new(:label => "label", :short => "spa ce")
      assert !category.valid?
      assert !category.save
    end
  end
end
