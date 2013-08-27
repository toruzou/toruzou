class ContactSerializer < ActiveModel::Serializer
  attributes :id, :type, :name, :address, :remarks
  has_one :owner
end
