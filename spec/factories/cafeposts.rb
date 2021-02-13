FactoryBot.define do
  factory :cafepost do
    
    content {"TEST_CONTENT"}
    name {"TEST_CAFENAME"}
    address {"TEST_ADDRESS"}
    prefecture {1}
    association :user
  end
end
