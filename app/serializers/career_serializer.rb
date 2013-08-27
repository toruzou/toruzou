class CareerSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :department, :title, :remarks
end
