# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization, :class => 'Organization' do
    sequence(:name) {|n| "Valid Organization #{n}"}
    sequence(:abbreviation) {|n| "org #{n}"}
    sequence(:address) {|n| "Valid address streeet #{n}"}
    sequence(:remarks) {|n| "Valid Organization's remarks #{n}"}
    sequence(:url) {|n| "Valid Organization's url #{n}"}
  end
end
