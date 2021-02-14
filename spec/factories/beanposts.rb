FactoryBot.define do
  factory :beanpost do
    name { "MyString" }
    image { "MyString" }
    amount { 1 }
    price { 1 }
    country { "MyString" }
    owner { nil }
  end
end
