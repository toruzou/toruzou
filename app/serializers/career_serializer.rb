class CareerSerializer < ActiveModel::Serializer
  attributes :id, :from_date, :to_date, :department, :title, :remarks
end
