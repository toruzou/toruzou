class Organization < Contact
  has_many :deals
  has_many :activities
  has_many :people

  validates :abbreviation, length: {maximum: 20}
  validates :url, length: {maximum: 100}
end
