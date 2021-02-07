FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_USERNAME#{n}"}
    sequence(:email) { |n| "USER#{n}@gmail.com"}
    sequence(:password) {|n| "#{n}"}
  end
  factory :another_user, class: User do
    sequence(:name) { |n| "TEST_ANOTHERUSERNAME#{n}"}
    sequence(:email) { |n| "ANOTHERUSER#{n}@gmail.com"}
    sequence(:password) {|n| "#{n}"}
  end
end