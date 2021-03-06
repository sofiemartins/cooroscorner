require 'rails_helper'

RSpec.describe Background, type: :model do
  describe "when creating a new background" do
    it "label needs to be present" do
      background = Background.new(:label => "")
      assert !background.valid?
      assert !background.save
    end

    it "label needs to be unique" do
      background = Background.new(:label => "label")
      assert background.valid?
      assert background.save
      background1 = Background.new(:label => "label")
      assert !background1.valid?
      assert !background1.save
    end
  end
end
