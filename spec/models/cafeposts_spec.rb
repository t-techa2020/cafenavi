require 'rails_helper'

RSpec.describe Cafepost, type: :model do
  before do
    @cafepost = build(:cafepost)
  end
  
  describe 'バリデーション' do
    it 'nameが空だとNG' do
      @cafepost.name = ''
      expect(@cafepost.valid?).to eq(false)
    end
  end
end
