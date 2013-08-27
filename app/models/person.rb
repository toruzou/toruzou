class Person < Contact
  belongs_to :organization
  has_many :careers
end
