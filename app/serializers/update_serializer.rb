class UpdateSerializer < ActiveModel::Serializer
  attributes :id, :type, :timestamp, :user_id, :message, :subject_type, :subject_id, :activity_id, :update_type
end
