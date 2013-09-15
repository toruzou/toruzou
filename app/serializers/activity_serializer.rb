class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :subject, :action, :date, :note, :done, :organization_id, :deal_id, :users_ids, :people_ids
  has_one :organization
  has_one :deal
  has_many :users
  has_many :people
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
  def deal_id
    object.deal.nil? ? nil : object.deal.id
  end
  def users
    object.users.order("name")
  end
  def users_ids
    object.users.pluck(:id)
  end
  def people
    object.people.order("name")
  end
  def people_ids
    object.people.pluck(:id)
  end
end
