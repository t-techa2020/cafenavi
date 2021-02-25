require 'rails_helper'

RSpec.describe Cafepost, type: :model do
  
  it "有効なファクトリを持つこと" do
    expect(build(:cafepost)).to be_valid
  end
  
  it "店名がなければ無効な状態であること" do
    cafepost = build(:cafepost, name: nil)
    cafepost.valid?
    
    expect(cafepost.errors[:name]).to include("を入力してください")
  end
  
  it "口コミがなければ無効な状態であること" do
    cafepost = build(:cafepost, content: nil)
    cafepost.valid?
    
    expect(cafepost.errors[:content]).to include("を入力してください")
  end
  
  it "都道府県が選択されていなければ無効な状態であること" do
    cafepost = build(:cafepost, prefecture: 0)
    cafepost.valid?
    
    expect(cafepost.errors[:prefecture]).to include("を選択してください")
  end
    
  it "住所がなければ無効な状態であること" do
    cafepost = build(:cafepost, address: nil)
    cafepost.valid?
    
    expect(cafepost.errors[:address]).to include("を入力してください")
  end
end
