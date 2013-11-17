class SalesProjectionSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :year, :period, :amount, :remarks
  has_one :deal
  def class_name
    object.class.name
  end
end
