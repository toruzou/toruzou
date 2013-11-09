class FollowingSerializer < ActiveModel::Serializer
  attributes :followable_type
  has_one :user
  has_one :followable
  def followable_type
    object.followable.class.name
  end
end
