class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :comments, :updated_at
end
