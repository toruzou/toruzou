class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :last_sign_in_at, :last_sign_in_ip
end
