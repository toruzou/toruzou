class Deal < ActiveRecord::Base
  belongs_to :organization
  belongs_to :pm, :class_name => "User"
  belongs_to :sales, :class_name => "User"
  belongs_to :contact, :class_name => "Person"
  has_many :activities
  has_many :attachments, :as => :attachable, :dependent => :delete_all
  has_many :updates, :as => :subject, :dependent => :delete_all
end
