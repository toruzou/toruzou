class UpdateSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :receivable, :created_at, :updated_at
  has_one :audit, serializer: AuditSerializer
  def class_name
    object.class.name
  end
end
