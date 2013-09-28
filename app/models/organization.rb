class Organization < Contact

  has_many :deals
  has_many :activities
  has_many :people

  validates :name, length: { maximum: 80 }
  validates :abbreviation, length: { maximum: 20 }
  validates :address, length: { maximum: 200 }
  validates :url, length: { maximum: 100 }
  
end
