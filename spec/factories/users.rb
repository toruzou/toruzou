FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:email) { |n| "sample#{n}@example.com" }
    sequence(:name) { |n| "Dummy ##{n}" }
    password 'hogehoge'
  end
end
