# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    sequence(:subject) { |n| "MyString #{n}" }
    date "2013-09-01"
    action 'Meeting'
    association :organization, factory: :organization
    association :deal, factory: :deal
    sequence(:people) { |n| [ FactoryGirl.create(:person, name: "participant 1 for #{n}"), 
      FactoryGirl.create(:person, name: "participant 2 for #{n}") ] }
    sequence(:users) { |n| [ FactoryGirl.create(:user, name: "participant 3 for #{n}"), 
      FactoryGirl.create(:user, name: "participant 4 for #{n}") ] }
    sequence(:note) { |n| "MyText #{n}" }

    done false
  end
end
