require 'rails_helper'

RSpec.describe Cafepost, type: :model do
  before do
    @user = create(:user)
  end
  
  it "is valid with name, content, prefecture, address and user_id" do
    user = @user
    @cafepost = user.cafeposts.build(
      name: "New Poppy",
      content: "New Poppy",
      prefecture: 1,
      address: "愛知県名古屋市",
      user_id: 1
      )
    expect(@cafepost).to be_valid
  end
end
