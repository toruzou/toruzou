FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n}
    email 'hoge@example.com'
    encrypted_password 'hoge'
    username 'example user'
    password 'hoge'
    password_confirmation 'hoge'
  end
end
