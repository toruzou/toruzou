class PersonSerializer < ActiveModel::Serializer

  attributes :id, :name, :organization_id, :phone, :email, :address, :remarks, :owner_id
  has_one :organization
  has_one :owner
  has_one :career
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
