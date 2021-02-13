require 'rails_helper'

RSpec.describe "Owners", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/owners/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/owners/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/owners/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/owners/create"
      expect(response).to have_http_status(:success)
    end
  end

end
