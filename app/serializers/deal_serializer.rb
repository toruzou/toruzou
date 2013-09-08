class DealSerializer < ActiveModel::Serializer
  attributes :id, :name, :organization_id, :start_date, :order_date, :accept_date, :amount, :accuracy, :status
  has_one :organization
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
end
