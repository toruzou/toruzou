class Organization < Contact
  has_many :deals
  has_many :activities
end
