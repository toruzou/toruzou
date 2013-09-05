class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :subject, :date, :note, :done
end
