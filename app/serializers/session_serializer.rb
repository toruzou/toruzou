class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :last_sign_in_at, :last_sign_in_ip
  has_many :my_followings
end
