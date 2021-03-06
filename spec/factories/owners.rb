FactoryBot.define do
  factory :owner do
    cafename { "MyString" }
    name { "MyString" }
    address { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    sequence(:email) { |n| "OWNER#{n}@example.com"}
    password {"aaaa"}
  end
end
