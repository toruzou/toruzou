class PersonSerializer < ActiveModel::Serializer
  attributes :id, :phone, :email
  has_one :organization
end
