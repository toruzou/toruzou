class SalesProjectionSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :year, :period, :amount, :remarks, :updated_at
  has_one :deal
  def class_name
    object.class.name
  end
end
