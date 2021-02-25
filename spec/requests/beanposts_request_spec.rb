require 'rails_helper'

RSpec.describe "Beanposts", type: :request do
  let(:beanpost) {create(:beanpost, owner: owner)}

  describe "#index" do
    context "認証済みのユーザー、オーナーとして" do
      let(:user) { create(:user) }
      let(:owner) { create(:owner) }
      
      it "正常にレスポンスを返すこと" do
        sign_in user
        sign_in owner
        get beanposts_url
        expect(response).to be_successful
      end
    
      it "200レスポンスを返すこと" do
        sign_in user
        sign_in owner
        get beanposts_url
        expect(response).to have_http_status(200)
      end
    end
    
    context "ゲストとして" do
      it "302レスポンスを返すこと" do
        get beanposts_url
        expect(response).to have_http_status(302)
      end
      
      it "ログイン画面にリダイレクトすること" do
        get beanposts_url
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "認証済みのユーザー、オーナーとして" do
      let(:user) { create(:user) }
      let(:owner) { create(:owner) }
      
      it "正常にレスポンスを返すこと" do
        sign_in user
        sign_in owner
        get beanposts_url beanpost.id
        expect(response).to be_successful
      end
    
      it "200レスポンスを返すこと" do
        sign_in user
        sign_in owner
        get beanposts_url beanpost.id
        expect(response).to have_http_status(200)
      end
    end
  end
  
  describe "#new" do
    let(:owner) { create(:owner) }
    
    it "200レスポンスを返すこと" do
      sign_in owner
      get new_beanpost_url
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "認証済みのオーナーとして" do
      let(:owner) { create(:owner) }
    
      it "コーヒー豆を追加できること" do
        beanpost_params = attributes_for(:beanpost)
        sign_in owner
        expect do
          post  beanposts_url, params: { beanpost: beanpost_params } 
        end.to change(Beanpost, :count).by(1)
      end
    end
    
    context "ゲストとして" do
      it "302レスポンスを返すこと" do
        beanpost_params = attributes_for(:beanpost)
        post  beanposts_url, params: { beanpost: beanpost_params }
        expect(response).to have_http_status(302)
      end
      
      it "ログイン画面にリダイレクトすること" do
        beanpost_params = attributes_for(:beanpost)
        post  beanposts_url, params: { beanpost: beanpost_params }
        expect(response).to redirect_to "/owners/sign_in"
      end
    end
  end
  
  describe "#edit" do
    context "認可されたオーナーとして" do
      let(:owner) { create(:owner) }
      let(:beanpost) {create(:beanpost, owner: owner)}
      
      it "正常にレスポンスを返すこと" do
        sign_in owner
        get edit_beanpost_url beanpost.id
        expect(response).to be_successful
      end
        
      it "200レスポンスを返すこと" do
        sign_in owner
        get edit_beanpost_url beanpost.id
        expect(response).to have_http_status(200)
      end
    end
      
    context "認可されていないオーナー、ユーザーとして" do
      let(:user) { create(:user) }
      let(:owner) { create(:owner) }
      let(:other_owner) { create(:owner) }
      let(:beanpost) {create(:beanpost, owner: other_owner)}
      
      it "トップページにリダイレクトすること" do
        sign_in user
        sign_in owner
        get edit_beanpost_url beanpost.id
        expect(response).to redirect_to root_url
      end
    end
  end
  
  describe "#update" do
    context "認可されたオーナーとして" do
      let(:owner) { create(:owner) }
      let(:beanpost) {create(:beanpost, owner: owner)}
    
      it "コーヒー豆を更新できること" do
        beanpost_params = attributes_for(:beanpost, name: "New Beans")
        sign_in owner
        put beanpost_url beanpost.id, params: { beanpost: beanpost_params } 
        expect(beanpost.reload.name).to eq "New Beans"
      end
    end
    
    context "認可されていないオーナーとして" do
      let(:user) { create(:user) }
      let(:owner) { create(:owner) }
      let(:other_owner) { create(:owner) }
      let(:beanpost) {create(:beanpost, owner: other_owner, name: "Same Old Beans")}
      
      it "コーヒー豆を更新できないこと" do
        beanpost_params = attributes_for(:beanpost, name: "New Beans")
        sign_in owner
        put beanpost_url beanpost.id, params: { beanpost: beanpost_params } 
        expect(beanpost.reload.name).to eq "Same Old Beans"
      end
      
      it "トップページへリダイレクトすること" do
        beanpost_params = attributes_for(:beanpost)
        sign_in owner
        put beanpost_url beanpost.id, params: { beanpost: beanpost_params } 
        expect(response).to redirect_to root_path
      end
    end
    
    context "ゲストとして" do
      let(:owner) { create(:owner) }
      let(:beanpost) { create(:beanpost, owner: owner) }
      
      it "302レスポンスを返すこと" do
        beanpost_params = attributes_for(:beanpost)
        put beanpost_url beanpost.id, params: { beanpost: beanpost_params }
        expect(response).to have_http_status(302)
      end
      
      it "ログイン画面にリダイレクトすること" do
        beanpost_params = attributes_for(:beanpost)
        put beanpost_url beanpost.id, params: { beanpost: beanpost_params }
        expect(response).to redirect_to "/owners/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "認可されたオーナーとして" do
      let(:owner) { create(:owner) }
      let(:beanpost) { create(:beanpost, owner: owner) }
      
      it "コーヒー豆を削除できること" do
        sign_in owner
        expect do
          delete beanpost_url beanpost.id
        end.to change(Beanpost, :count).by(0)
      end
    end
      
    context "認可されていないオーナーとして" do
      let(:user) { create(:user) }
      let(:owner) { create(:owner) }
      let(:other_owner) { create(:owner) }
      let(:beanpost) { create(:beanpost, owner: other_owner) }
      
      it "コーヒー豆を削除できないこと" do
        sign_in owner
        expect do
          delete beanpost_url beanpost.id
        end.to change(Beanpost, :count).by(1)
      end
      
      it "トップページにリダイレクトすること" do
        sign_in owner
        put beanpost_url beanpost.id
        expect(response).to redirect_to root_path
      end
    end
        
    context "ゲストとして" do
      let(:owner) { create(:owner) }
      let(:beanpost) { create(:beanpost, owner: owner) }
    
      it "302レスポンスを返すこと" do
        delete beanpost_url beanpost 
        expect(response).to have_http_status(302)
      end
      
      it "ログイン画面にリダイレクトすること" do
        delete beanpost_url beanpost 
        expect(response).to redirect_to "/owners/sign_in"
      end
      
      it "コーヒー豆を削除できないこと" do
        expect do
          delete beanpost_url beanpost.id
        end.to change(Beanpost, :count).by(1)
      end
    end
  end
end