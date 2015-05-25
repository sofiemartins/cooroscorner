require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

   it "renders the index template" do
     get :index
     expect(response).to render_template("index")
   end
  end

  describe "GET #about" do
    it "responds successfully with an HTTP 200 code" do
      get :about
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the about template" do
      get :about
      expect(response).to render_template("about")
    end
  end

end
