class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :address, :remarks, :url, :owner
end
