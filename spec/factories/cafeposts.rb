FactoryBot.define do
  factory :cafepost do
    
    before(:create) do |user|
      create_list(:user, 1, cafepost: cafepost)
    end
    
    sequence(:content) { |n| "TEST_CONTENT#{n}"}
    sequence(:name) { |n| "TEST_CAFENAME#{n}"}
    sequence(:address) { |n| "TEST_ADDRESS#{n}"} 
  end
end
