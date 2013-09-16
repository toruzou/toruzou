FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n}
    email 'hoge@example.com'
    name 'example user'
  end
end
