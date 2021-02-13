require 'rails_helper'

RSpec.describe "Cafeposts", type: :request do
  describe "#index" do
    before do
      @user = create(:user)
    end
    
    it "正常にレスポンスを返すこと" do
      sign_in @user
      
      get cafeposts_url
      expect(response.status).to eq 200
    end
  end
end
