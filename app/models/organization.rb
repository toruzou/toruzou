class Organization < Contact

  has_many :deals
  has_many :activities
  has_many :people

  validates :name, length: { maximum: 80 }
  validates :abbreviation, length: { maximum: 20 }
  validates :address, length: { maximum: 200 }
  validates :url, length: { maximum: 100 }

  audit :name, :owner, :address, :remarks, :abbreviation, :url, :deleted_at
  
  def update_destinations_for(audit)
    [ self ]
  end

end
