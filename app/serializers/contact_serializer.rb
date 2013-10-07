class ContactSerializer < ActiveModel::Serializer
  attributes :id, :type, :name, :address, :remarks, :deleted_at
  has_one :owner
end
