class AuditSerializer < ActiveModel::Serializer
  attributes :id, :auditable_type, :action, :tag, :created_at, :updated_at, :changes
  has_one :user
  has_one :auditable
  def auditable_type
    object.auditable.class.name
  end
  def changes
    object.latest_diff.select { |key, diff| diff[0].present? or diff[1].present? }
  end
end