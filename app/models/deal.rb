class Deal < ActiveRecord::Base
  belongs_to :organization
  belongs_to :person
  belongs_to :pm, class_name: 'User'
  belongs_to :sales, class_name: 'User'
end
