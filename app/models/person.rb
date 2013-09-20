class Person < Contact

  belongs_to :organization
  has_many :careers, :dependent => :destroy
  has_many :deals
  has_many :participants, :as => :participable, :dependent => :destroy
  has_many :activities, :as => :participable, :through => :participants
  has_many :attachments, :as => :attachable, :dependent => :delete_all

  def latest_career
    careers.sort.first
  end

end
