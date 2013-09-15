class DealSerializer < ActiveModel::Serializer
  attributes :id, :name, :organization_id, :contact_id, :pm_id, :sales_id, :start_date, :order_date, :accept_date, :amount, :accuracy, :status
  has_one :organization
  has_one :contact
  has_one :pm
  has_one :sales
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
  def contact_id
    object.contact.nil? ? nil : object.contact.id
  end
  def pm_id
    object.pm.nil? ? nil : object.pm.id
  end
  def sales_id
    object.sales.nil? ? nil : object.sales.id
  end
end
