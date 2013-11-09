class AuditSerializer < ActiveModel::Serializer
  attributes :id, :action, :tag, :created_at, :updated_at, :changes
  has_one :user
  has_one :auditable
  def changes
    object.latest_diff.select { |key, diff| diff[0].present? or diff[1].present? }
  end
end