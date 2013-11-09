class CareerSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :from_date, :to_date, :department, :title, :remarks
  has_one :person
  def class_name
    object.class.name
  end
end
