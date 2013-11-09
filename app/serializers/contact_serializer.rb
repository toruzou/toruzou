class ContactSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :type, :name, :address, :remarks, :deleted_at
  has_one :owner
  def class_name
    object.class.name
  end
end
