class PersonSerializer < ActivityAwareSerializer
  attributes :id, :name, :organization, :organization_id, :phone, :email, :address, :remarks, :career, :owner, :owner_id, :deleted_at
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
  def career
    object.latest_career
  end
end
