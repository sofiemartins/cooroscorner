require 'rails_helper'

RSpec.describe ComicController, type: :controller do
  include ActionView::Helpers::UrlHelper

  $allcategories = [ "offensive", "random", "mayuyu", "tina", "alice" ]

  describe "GET show_last" do
    it "gets with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        visit "/#{category}"
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET show" do
    it "gets with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        puts category
        comic = Comic.new(:category => category)
        comic.save
        get :show, :category => category, :index => '1'
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    it "renders template for every category" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        get :show, :category => category, :index => '1'
        expect(response).to render_template("show") 
      end
    end
  end

  describe "GET back" do
    it "gets back with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        comic.save
        get :back, :category => category, :index => '2'
        expect(response).to have_http_status(200)
      end
    end

    it "renders template after the back path" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        get :back, :category => category, :index => '1'
        expect(response).to render_template("show")
      end
    end
  end

  describe "GET next" do
    it "gets next with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        get "/next/#{category}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    it "renders the template after the next redirect" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        get "/next/#{category}/1"
        expect(response).to render_template("show")
      end
    end
  end

  describe "GET random" do
    it "gets random with success and HTTP 200 for every category" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        get "/random/#{category}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    it "renders template after random redirect" do
      $allcategories.each do |category|
        comic = Comic.new(:category => category)
        comic.save
        get "/random/#{category}/1"
        expect(response).to render_template("show")
      end
    end
  end
end
