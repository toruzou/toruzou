# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deal do
    pj_type "MyString"
    organization_id 1
    counter_person 1
    pm 1
    sales 1
    start_date "2013-09-01"
    order_date "2013-09-01"
    accept_date "2013-09-01"
    amount 1
    accuracy "MyString"
    status "MyString"
  end
end
