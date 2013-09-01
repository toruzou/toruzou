class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :note, :done
end
