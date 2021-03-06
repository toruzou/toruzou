class User < ActiveRecord::Base

  include Followable

  has_many :participants, :as => :participable, :dependent => :destroy
  has_many :activities, :as => :participable, :through => :participants
  has_many :updates, :as => :receivable
  has_many :my_followings, ->(user) { where user_id: user.id }, class_name: "Following"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name,
    :uniqueness => {
      :case_sensitive => false
    }

  def update_destinations_for(audit)
    []
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
