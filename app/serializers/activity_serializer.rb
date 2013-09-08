class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :subject, :action, :date, :note, :done, :organization_id, :deal_id
  has_one :organization
  has_one :deal
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
  def deal_id
    object.deal.nil? ? nil : object.deal.id
  end
end
