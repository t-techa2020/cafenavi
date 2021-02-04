FactoryBot.define do
  factory :cafepost do
    sequence(:name) { |n| "TEST_CAFENAME#{n}"}
    sequence(:content) { |n| "TEST_CONTENT#{n}"}
    sequence(:address) { |n| "TEST_ADDRESS#{n}"}
  end
end
