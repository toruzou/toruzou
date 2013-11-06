class Contact < ActiveRecord::Base

  acts_as_paranoid
  include Followable

  belongs_to :owner, :class_name => "User"
  has_many :attachments, :as => :attachable
  has_many :updates, :as => :receivable
  has_many :audits, :as => :auditable

  validates :name, presence: true
  validates :name, length: { maximum: 80 }
  validates :address, length: { maximum: 200 }
  validates :remarks, length: { maximum: 5000 }

  scope :match_name, ->(q) {
    where("lower(contacts.name) LIKE ?", "%#{q.downcase}%")
  }

end
