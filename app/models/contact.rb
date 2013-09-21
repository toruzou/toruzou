class Contact < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"

  validates :name, presence: true
  validates :name, length: {maximum: 80}
  validates :address, length: {maximum: 200}
  validates :remarks, length: {maximum: 500}

  scope :has_name, lambda { |value|
    where("lower(contacts.name) LIKE ?", "%#{value.downcase}%")
  }
end
