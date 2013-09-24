class UpdateSerializer < ActiveModel::Serializer
  attributes :id, :type, :user, :subject_type, :subject_id, :subject_name, :action, :created_at, :updated_at
  def subject_type
    object.subject.class.name
  end
  def subject_name
    object.subject.name
  end
end
