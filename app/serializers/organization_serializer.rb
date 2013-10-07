class OrganizationSerializer < ActivityAwareSerializer
  attributes :id, :name, :abbreviation, :address, :remarks, :url, :owner, :owner_id, :deleted_at
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
end
