FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n}
    email 'hoge@example.com'
    username 'example user'
  end
end
