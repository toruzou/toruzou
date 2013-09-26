# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deal do

    sequence(:name) { |n| "sample deal #{n}" }
    association :organization, factory: :organization
    association :pm, factory: :user
    association :sales, factory: :user
    association :contact, factory: :person

  end
end
