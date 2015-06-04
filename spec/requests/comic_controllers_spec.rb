require 'rails_helper'

RSpec.describe "ComicControllers", type: :request do

  describe "GET /:category" do
    it "asserts right redirect with HTTP 302" do
      setup
      Category.all.each do |category|   
        get "/#{category.short}/"
        expect(response).to have_http_status(302)
        assert_redirected_to "/#{category.short}/2"
      end
    end
  end

  describe "GET /:category/:index" do
    it "shows element with the given index with HTTP 200" do
      setup
      Category.all.each do |category|
        get "/#{category.short}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    it "renders a template" do
      setup
      Category.all.each do |category|
        get "/#{category.short}/1"
        expect(response).to render_template("show")
      end
    end
  end

  describe "GET /back/:category/:index" do
    it "redirects back with HTTP 302" do
      setup
      Category.all.each do |category|
        get "/back/#{category.short}/2"
        expect(response).to have_http_status(302)
        assert_redirected_to "/#{category.short}/1"
      end
    end
  end

  describe "GET /next/:category/:index" do
    it "redirects next with HTTP 302" do
      setup
      Category.all.each do |category|
        get "/next/#{category.short}/1"
        expect(response).to have_http_status(302)
        assert_redirected_to "/#{category.short}/2"
      end
    end
  end

  describe "GET /random/:category/:index" do
    it "redirects to random comic page with HTTP 302" do
      setup
      Category.all.each do |category|
        get "/random/#{category.short}/1"
        expect(response).to have_http_status(302)
      end
    end 
  end

  describe "GET new" do
    it "raises not found when not logged in" do
      expect{ get :new }.to raise_error{ ActionController::RoutingError }
    end

    it "raises not found when logged in as normal user" do
      setup_user
      expect{ get :new }.to raise_error{ ActionController::RoutingError }
    end

    it "renders template successful with HTTP 200" do
      setup_admin
      expect(response).to be_success
      expect(response).to have_http_status(200) 
      expect(response).to render_template("new")
    end
  end

  describe "GET create" do
    it "raises not found when not logged in" do
      expect{ get :create }.to raise_error{ ActionController::RoutingError }
    end

    it "raises not found when logged in as normal user" do
      expect{ get :create }.to raise_error{ ActionController::RoutingError }
    end

    it "changes the number of comics" do
      initial_count = Comic.count
      setup_admin
      post "/upload"
      assert Comic.count == (initial_count + 1)
    end
  end

  describe "GET edit" do
    it "raises not found, when not logged in" do
      setup
      Comic.all.each do |comic|
        index = Comic.where(:category => comic.category).index(comic)
        expect{ get "/edit/comic/#{comic.category}/#{index}"}.to 
			raise_error{ ActionController::RoutingError }
      end
    end

    it "raises not found, when logged in as normal user" do
      setup
      setup_user
      Comic.all.each do |comic|
        index = Comic.where(:category => comic.category).index(comic)
        expect{ get "/edit/comic/#{comic.category}/#{index}" }.to
			raise_error{ ActionController::RoutingError }
      end
    end

    it "renders template successful with HTTP 200" do
      setup
      setup_admin
      Comic.all.each do |comic|
        index = Comic.where(:category => comic.category).index(comic)
        get "/edit/comic/#{comic.category}/#{index}"
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("edit")
      end
    end
  end

  private 
    def setup
      setup_categories
      setup_example_comics
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
    end

  private 
    def setup_admin
      user = User.new(email: "email@email.com", username: "admin",
			password: "password",
			password_confirmation: "password",
			admin: true)
      user.save
      sign_in(user)
    end

  private 
    def setup_user
      user = User.new(email: "email@email.com", username: "user",
			password: "password",
			password_confirmation: "password",
			admin: false)
      user.save
      sign_in(user)
    end

end
