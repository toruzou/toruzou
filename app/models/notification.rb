class Notification < ActiveRecord::Base

  belongs_to :audit, :class_name => "Auditable::Audit"
  belongs_to :user
  
end
