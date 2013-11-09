class PersonSerializer < ActivityAwareSerializer
  attributes :class_name, :id, :name, :organization, :organization_id, :phone, :email, :address, :remarks, :career, :owner, :owner_id, :deleted_at, :following
  def class_name
    object.class.name
  end
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
  def career
    object.latest_career
  end
  def following
    object.followed_by?(scope.current_user)
  end
end
