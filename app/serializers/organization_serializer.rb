class OrganizationSerializer < ActivityAwareSerializer
  attributes :id, :name, :abbreviation, :address, :remarks, :url, :owner, :owner_id, :deleted_at, :following
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
  def following
    object.followed_by?(scope.current_user)
  end
end
