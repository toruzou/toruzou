class UpdateSerializer < ActiveModel::Serializer
  attributes :id, :receivable, :created_at, :updated_at
  has_one :audit, serializer: AuditSerializer
end
