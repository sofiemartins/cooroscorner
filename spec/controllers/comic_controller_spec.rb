require 'rails_helper'

RSpec.describe ComicController, type: :controller do
  include ActionView::Helpers::UrlHelper

  describe "GET show_last" do
    it "gets with success and HTTP 200 for every category" do
      Category.all.each do |category|
        link_to "Connect", "/#{category.short}"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET show" do
    it "gets with success and HTTP 200 for every category" do
      Category.all.each do |category|
        link_to "Connect", "/#{category.short}/1"
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

end
