class Person < Contact
  belongs_to :organization
  has_many :careers
  has_many :deals
  has_many :participants, :as => :participable, :dependent => :destroy
  has_many :activities, :as => :participable, :through => :participants

  scope :has_organization_id, lambda { |organization_id|
    where(organization_id: organization_id)
  }

  scope :include_email, lambda { |value|
    where("lower(contacts.email) LIKE ?", "%#{value.downcase}%")
  }

  scope :include_phone, lambda { |value|
    where("lower(contacts.phone) LIKE ?", "%#{value.downcase}%")
  }

  scope :in_organization, lambda { |value|
    joins(:organization).where("lower(organizations_contacts.name) LIKE ?", "%#{value.downcase}%")
  }

  scope :include_owner, lambda { |value| 
    joins(:owner).where("lower(users.name) LIKE ?", "%#{value.downcase}%")
  }


  # name, address and remarks is validated in Contact.rb
  validates :phone, length: { minimum: 12, maximum: 13 },
                    format: { with: /\A\d{2,4}-\d{2,4}-\d{4}\z/ },
                    if: :phone_is_filled
  validates :email, length: { maximum: 200 }, 
                    email_format: {message: 'invalid e-mail format', 
                                   allow_nil: true,
                                   allow_blank: true } 

  private 
    def phone_is_filled
      return self.phone != nil && self.phone != ""
    end
end
