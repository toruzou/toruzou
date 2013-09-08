class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :subject, :action, :date, :note, :done, :organization_id
  has_one :organization
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
end
