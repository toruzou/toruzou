class Person < Contact
  belongs_to :organization
  has_many :careers
  has_many :deals
  has_many :participants, :as => :participable, :dependent => :destroy
  has_many :activities, :as => :participable, :through => :participants

  scope :in_organization, lambda { |organization_id|
    where(organization_id: organization_id)
  }

end
