require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "有効なファクトリを持つこと" do
    expect(build(:user)).to be_valid
  end
  
  it "名前がなければ無効な状態であること" do
    user = build(:user, name: nil)
    user.valid?
    
    expect(user.errors[:name]).to include("を入力してください")
  end
  
  it "メールアドレスがなければ無効な状態であること" do
    user = build(:user, email: nil)
    user.valid?
    
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  it "パスワードがなければ無効な状態であること" do
    user = build(:user, password: nil)
    user.valid?
    
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
    create(:user, email: "tester@example.com")
    
    user = build(:user, email: "tester@example.com")
    user.valid?
    
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end