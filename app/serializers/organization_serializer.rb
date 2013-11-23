class OrganizationSerializer < ActivityAwareSerializer
  attributes :class_name, :id, :name, :abbreviation, :address, :remarks, :url, :owner, :owner_id, :updated_at, :deleted_at, :following
  def class_name
    object.class.name
  end
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
  def following
    object.followed_by?(scope.current_user)
  end
end
