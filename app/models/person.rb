class Person < Contact

  belongs_to :organization
  has_many :careers, :dependent => :destroy
  has_many :deals
  has_many :participants, :as => :participable, :dependent => :destroy
  has_many :activities, :as => :participable, :through => :participants
  has_many :attachments, :as => :attachable, :dependent => :delete_all

  scope :in_organization, ->(organization_id) {
    where(organization_id: organization_id)
  }

  scope :match_email, ->(q) {
    where("lower(contacts.email) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_phone, ->(q) {
    where("lower(contacts.phone) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_organization, ->(q) {
    joins(:organization).where("lower(organizations_contacts.name) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_owner, ->(q) { 
    joins(:owner).where("lower(users.name) LIKE ?", "%#{q.downcase}%")
  }

  validates :phone, length: { minimum: 12, maximum: 13 }, format: { with: /\A\d{2,4}-\d{2,4}-\d{4}\z/ }, if: :phone_is_filled
  validates :email, length: { maximum: 200 }, email_format: { message: 'Invalid Email format', allow_nil: true, allow_blank: true } 

  def latest_career
    careers.sort.first
  end

  private 
  
    def phone_is_filled
      return self.phone != nil && self.phone != ""
    end

end
