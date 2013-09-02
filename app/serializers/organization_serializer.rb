class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :address, :remarks, :url, :owner_id
  has_one :owner
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
end
