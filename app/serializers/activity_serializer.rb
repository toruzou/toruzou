class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :subject, :action, :date, :note, :done, :organization, :organization_id, :deal, :deal_id, :users, :users_ids, :people, :people_ids, :deleted_at
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
