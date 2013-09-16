# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person, :class => 'Person' do
    sequence(:name) {|n| "Valid Person #{n}"}
    sequence(:address) {|n| "Valid address streeet #{n}"}
    sequence(:remarks) {|n| "Valid Organization's remarks #{n}"}
    sequence(:url) {|n| "Valid Organization's url #{n}"}
  end
end
