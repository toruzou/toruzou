class Person < Contact
  belongs_to :organization
  has_many :careers
  has_many :deals
  has_many :participants, :as => :participable, :dependent => :destroy
  has_many :activities, :as => :participable, :through => :participants
end
