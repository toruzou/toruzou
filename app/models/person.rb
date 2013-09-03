class Person < Contact
  belongs_to :organization
  has_many :careers
  has_many :deals
end
