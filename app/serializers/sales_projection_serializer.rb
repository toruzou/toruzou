class SalesProjectionSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :year, :period, :amount, :remarks, :organization
  has_one :deal
  def class_name
    object.class.name
  end
  def organization
    object.deal.organization
  end
end
