class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :comments, :updated_at, :attachable_type
  has_one :attachable
  def attachable_type
    object.attachable.class.name
  end
end
