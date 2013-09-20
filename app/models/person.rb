class Person < Contact
  belongs_to :organization
  has_many :careers
  has_many :deals
  has_many :participants, :as => :participable, :dependent => :destroy
  has_many :activities, :as => :participable, :through => :participants

  scope :in_organization, lambda { |organization_id|
    where(organization_id: organization_id)
  }

  # name, address and remarks is validated in Contact.rb
  validates :phone, length: { minimum: 12, maximum: 13 },
                    format: { with: /\A\d{2,4}-\d{2,4}-\d{4}\z/ },
                    if: :phone_is_filled
  validates :email, length: { maximum: 200 }, 
                    email_format: {:message => 'invalid e-mail format'},
                    if: :email_is_filled
  

  private 
    def phone_is_filled
      return self.phone != nil && self.phone != ""
    end

    def email_is_filled
      return self.email != nil && self.email != ""
    end

end
