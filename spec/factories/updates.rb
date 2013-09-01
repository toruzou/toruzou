# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    type ""
    timestamp "2013-09-01"
    user_id 1
    message "MyString"
    subject_type "MyString"
    subject_id 1
    activity_id 1
    update_type "MyString"
  end
end
