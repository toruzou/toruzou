class NoteSerializer < ActiveModel::Serializer
  attributes :id, :subject_type, :subject, :message
  def subject_type
    object.subject.class.name
  end
end
