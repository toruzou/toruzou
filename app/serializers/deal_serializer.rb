class DealSerializer < ActiveModel::Serializer
  attributes :class_name,
    :id,
    :name,
    :project_type,
    :category,
    :organization,
    :organization_id,
    :contact,
    :contact_id,
    :pm,
    :pm_id,
    :sales,
    :sales_id,
    :start_date,
    :accept_date,
    :following,
    :total_amount,
    :updated_at,
    :deleted_at
  def class_name
    object.class.name
  end
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
  def following
    object.followed_by?(scope.current_user)
  end
end
