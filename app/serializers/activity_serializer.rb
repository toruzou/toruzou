class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :subject, :action, :date, :note, :done
end
