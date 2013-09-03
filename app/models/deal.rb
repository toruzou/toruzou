class Deal < ActiveRecord::Base
  belongs_to :organization
  has_and_belongs_to_many :people
  has_and_belongs_to_many :users

end
