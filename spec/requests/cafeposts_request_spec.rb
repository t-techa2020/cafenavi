require 'rails_helper'

describe CafepostsController, type: :controller do
  before do
    @user = create(:user)
    @another = create(:another_user)
    @cafepost = create(:cafepost)
  end
  
  describe '#index' do
  
  end
  
  describe '#show' do
    context "as an authorized user" do
      # 正常なレスポンスか？
      it "responds successfully" do
        sign_in @user
        get :show, params: {id: @cafepost.id}
        expect(response).to be_success
      end
      # 200レスポンスが返ってきているか？
      it "returns a 200 response" do
        sign_in @user
        get :show, params: {id: @cafepost.id}
        expect(response).to have_http_status "200"
      end
    end
  end
end