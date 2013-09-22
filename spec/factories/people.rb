# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person, :class => 'Person' do
    sequence(:name) {|n| "Valid Person #{n}"}
    sequence(:address) {|n| "Valid address streeet #{n}"}
    sequence(:email) {|n| "example#{n}@sample.com"}
    sequence(:phone) {|n| "090-00#{n}-0000"}
    sequence(:remarks) {|n| "Valid Organization's remarks #{n}"}
    sequence(:url) {|n| "Valid Organization's url #{n}"}
  end
end
