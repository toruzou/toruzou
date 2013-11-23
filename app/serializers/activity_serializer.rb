class ActivitySerializer < ActiveModel::Serializer
  attributes :class_name, :id, :name, :action, :date, :note, :done, :organization, :organization_id, :deal, :deal_id, :users, :users_ids, :people, :people_ids, :updated_at, :deleted_at
  def class_name
    object.class.name
  end
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
