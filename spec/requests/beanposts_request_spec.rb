require 'rails_helper'

RSpec.describe "Beanposts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/beanposts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/beanposts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/beanposts/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/beanposts/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
