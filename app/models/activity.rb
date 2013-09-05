class Activity < ActiveRecord::Base
  belongs_to :organization
  belongs_to :deal
  has_and_belongs_to_many :people
end
