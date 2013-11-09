class AttachmentSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :name, :comments, :updated_at, :attachable_type
  has_one :attachable
  def class_name
    object.class.name
  end
  def attachable_type
    object.attachable.class.name
  end
end
