class PersonSerializer < ActiveModel::Serializer

  # TODO title, department

  attributes :id, :name, :organization_id, :phone, :email, :address, :remarks, :owner_id
  has_one :organization
  has_one :owner
  def organization_id
    object.organization.nil? ? nil : object.organization.id
  end
  def owner_id
    object.owner.nil? ? nil : object.owner.id
  end
  
end
