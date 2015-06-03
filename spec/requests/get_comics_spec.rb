require 'rails_helper'

RSpec.describe "GetComics", type: :request do
  $allcategories = [ "offensive", "random", "mayuyu", "tina", "alice" ]

  describe "GET show_last" do
    scenario "get offensive 1" do
      comic = Comic.new(category: "offensive")
      comic.save
      get '/offensive/1'
      expect(response).to have_http_status(200) 
    end 

    scenario "gets and redirects" do
      $allcategories.each do |category|
        comic = Comic.new(category: category)
        comic.save
        get "/#{category}"
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET show" do
    scenario "gets with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        comic = Comic.new(category: category)
        comic.save
        get "/#{category}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    scenario "renders template" do
      $allcategories.each do |category|
        comic = Comic.new(category: category)
        comic.save
        get "/#{category}/1"
        expect(response).to render_template("show")
      end
    end
  end

  describe "GET back" do
    scenario "gets and redirects" do
      $allcategories.each do |category|
        comic = Comic.new(category: category)
        comic.save
        comic.save
        get "/back/#{category}/2"
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET next" do
    scenario "gets and redirects" do
      $allcategories.each do |category|
        comic = Comic.new(category: category)
        comic.save
        comic.save
        get "/next/#{category}/1"
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET random" do
    scenario "gets and redirects" do
      $allcategories.each do |category|
        comic = Comic.new(category: category)
        comic.save 
        comic.save
        get "/random/#{category}/1"
        expect(response).to have_http_status(200)
      end
    end
  end

end
