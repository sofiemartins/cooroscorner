require 'rails_helper'

RSpec.describe Comic, type: :model do

  describe "image" do
    it "must not be nil" do
      comic = Comic.new 
      assert !comic.valid?
      assert !comic.save
      comic1 = Comic.new(:image => "test.jpg")
      assert comic.valid?
      assert comic.save
    end
  end

end
