FactoryBot.define do
  factory :user do
    name { "TEST_USERNAME"}
    sequence(:email) { |n| "USER#{n}@example.com"}
    password {"aaaa"}
  end
  factory :another_user, class: User do
    name { "TEST_ANOTHERUSERNAME"}
    sequence(:email) { |n| "ANOTHERUSER#{n}@example.com"}
    password {"aaaa"}
  end
end