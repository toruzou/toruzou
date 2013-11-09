class NoteSerializer < ActiveModel::Serializer
  attributes :class_name, :id, :subject_type, :subject, :message
  def class_name
    object.class.name
  end
  def subject_type
    object.subject.class.name
  end
end
