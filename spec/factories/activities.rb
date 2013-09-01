# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    title "MyString"
    date "2013-09-01"
    note "MyText"
    done false
  end
end
