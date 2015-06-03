require 'rails_helper'

RSpec.describe "ComicControllers", type: :request do

  describe "GET /:category" do
    it "shows last added element" do
      setup_categories
      setup_example_comics
      Category.all.each do |category|   
        get "/#{category.short}"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  private
    def setup_categories
      setup_category("Offensively Offensive", "offensive")
      setup_category("Random", "random")
      setup_category("Mayuyus Anger Management Diaries", "mayuyu")
      setup_category("Tina And Her Funny Friends", "tina")
      setup_category("Alice in Wonderland", "alice")
    end

  private
    def setup_category(label, short)
      category = Category.new(:label => label, :short => short)
      category.save
    end

  private 
    def setup_example_comics
      Category.all.each do |category|
        setup_comic(category)
        setup_comic(category)
      end
    end

  private
    def setup_comic(category)
      comic = Comic.new(:category => category.short)
      comic.save
      puts Comic.count
    end

end
