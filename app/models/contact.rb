class Contact < ActiveRecord::Base

  belongs_to :owner, :class_name => "User"
  has_many :attachments, :as => :attachable, :dependent => :delete_all
  has_many :updates, :as => :subject, :dependent => :delete_all

  validates :name, presence: true
  validates :name, length: { maximum: 80 }
  validates :address, length: { maximum: 200 }
  validates :remarks, length: { maximum: 5000 }

  scope :match_name, ->(q) {
    where("lower(contacts.name) LIKE ?", "%#{q.downcase}%")
  }

end
