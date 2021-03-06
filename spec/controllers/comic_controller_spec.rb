require 'rails_helper'

RSpec.describe ComicController, type: :controller do

  describe "GET :show" do
    it "shows element with the given index with HTTP 200" do
      setup_database
      Category.all.each do |category|
        get :show, :category => category.abbreviation, :index => 1
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    it "renders template" do
      setup_database
      Category.all.each do |category|
        get :show, :category => category.abbreviation, :index => 1
        expect(response).to render_template("show")
      end
    end
  end

  describe "GET :archive_last" do
    it "redirects to the archive page with the last index" do
      setup_database
      last_index = Comic.count
      get :archive_last
      expect(response).to have_http_status(302)
      assert_redirected_to "/archive/#{last_index}"
    end
  end

  describe "GET :archive" do
    it "responds successful with HTTP 200" do
      setup_database
      get :archive, :index => "1"
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders template" do
      setup_database
      get :archive, :index => "1"
      expect(response).to render_template("archive")
    end
  end

  describe "GET new" do
    it "raises not found when not logged in" do
      expect{ get :new }.to raise_error{ ActionController::RoutingError }
    end

    it "renders template successful with HTTP 200 when logged in as admin" do
      setup_user
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200) 
      expect(response).to render_template("new")
    end
  end

  describe "GET create" do
    it "raises not found when not logged in" do
      expect{ get :create }.to raise_error{ ActionController::RoutingError }
    end

    it "changes the number of comics when logged in as admin" do
      setup_database
      setup_user
      initial_comic_count = Comic.count
      post :create, :comic => { :title => "title",
				:category => "Offensively Offensive",
				:authors_comment => "some comment here",
				:image => "test.jpg" } 
      expect(response).to have_http_status(302)
      assert_redirected_to "/upload"
      assert Comic.count == initial_comic_count +1
    end

    it "saves comic with the abbreviation of the given category" do
      setup_database
      setup_user
      post :create, :comic => { :title => "very very unique title",
				:category => "Offensively Offensive",
				:authors_comment => "some comment here",
				:image => "test.jpg" }
      assert Comic.find_by(:title => "very very unique title").category == "offensive"
    end
  end

  describe "GET edit" do
    it "raises not found, when not logged in" do
      setup_database
      Comic.all.each do |comic|
        index = Comic.where(:category => comic.category).index(comic)
        expect{ get :edit, :category => comic.category, :index => index }.to raise_error{ ActionController::RoutingError }
      end
    end

    it "renders template successful with HTTP 200 when logged in as admin" do
      setup_database
      setup_user
      Comic.all.each do |comic|
        index = Comic.where(:category => comic.category).index(comic)
        get :edit, :category => comic.category, :index => index
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET submit_edit" do
    it "raises not found, when not logged in" do
      setup_database
      Comic.all.each do |comic|
        index = Comic.where(:category => comic.category).index(comic)
        expect{ post :submit_edit, :category => comic.category, :index => index, :comic => FactoryGirl.build(:comic).attributes }.to raise_error{ ActionController::RoutingError}
      end
    end

    it "submits edit when logged in as admin" do
      setup_database
      setup_user
      Comic.all.each do |comic|
        index = Comic.where(:category => comic.category).index(comic) + 1
        post :submit_edit, :category => comic.category, :index => index, :comic => { :title => "new title" } 
        assert_redirected_to "/list/comics"
      end
    end

    it "submits edit and edits the right comic" do
      setup_database
      setup_user
      new_title = "new title"
      comic = create_test_comic
      index = Comic.where(:category => comic.category).index(comic) + 1
      get :submit_edit, :category => comic.category, :index => index, 
			:comic => { :title => new_title }
      edited_comic = Comic.where(:category => comic.category).fetch(index - 1)
      assert edited_comic.title == new_title
    end
  end

  describe "GET destroy" do
    it "raises not found when not logged in" do
      setup_database
      comic = create_test_comic
      index = Comic.where(:category => comic.category).index(comic)
      assert !!comic
      assert !!Comic.find_by(:id => comic.id)
      expect{ get :destroy, :category => comic.category, :index => index }.to raise_error{ ActionController::RoutingError }
    end

    it "destroys comic, when logged in as admin and returns HTTP 200" do
      setup_database
      setup_user
      comic = create_test_comic
      index = Comic.where(:category => comic.category).index(comic) + 1
      assert !!comic
      assert !!Comic.find_by(:id => comic.id)
      get :destroy, :category => comic.category, :index => index
      assert !Comic.find_by(:id => comic.id)
      expect(response).to have_http_status(302)
      assert_redirected_to "/list/comics"
    end
  end

  describe "GET :comment" do
    it "creates a comment" do
      comic = create_test_comic
      index = Comic.where(:category => comic.category).index(comic) + 1
      initial_comment_count = Comment.count
      post :comment, :category => comic.category, :index => index, :comment => FactoryGirl.build(:comment).attributes
      assert Comment.count == initial_comment_count + 1
    end
  end

  describe "GET :list" do
    it "raises not found, when nobody is logged in" do
      setup_database
      expect{ get :list }.to raise_error{ ActionController::RoutingError }
    end

    it "gets successful with HTTP 200, when logged in as admin" do
      setup_database
      setup_user
      get :list
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  private 
    def setup_database
      setup_categories
      setup_example_comics
      setup_example_comments
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
    def setup_category(label, abbreviation)
      category = Category.new(:label => label, :abbreviation => abbreviation)
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
      comic = Comic.new(:category => category.abbreviation, :title => "some title", :authors_comment => "some comment")
      comic.save
    end

  private 
    def setup_user
      user = User.new(email: "email@email.com", username: "user",
			password: "password",
			password_confirmation: "password" )
      user.save
      sign_in user
    end

  private
    def create_test_comic
      comic = Comic.new(:title => "title",
			:category => "mayuyu",
			:authors_comment => "comment")
      comic.save
      return comic
    end

  private
    def setup_example_comments
      Comic.all.each do |comic|
        comment = Comment.new(:content => "content", :name => "some_alias", 
				:comic_index => Comic.all.index(comic))
        comment.save
      end
    end

end
