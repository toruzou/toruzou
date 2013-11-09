class UserSerializer < ActivityAwareSerializer
  attributes :class_name, :id, :name, :email, :last_sign_in_at, :last_sign_in_ip, :following
  def class_name
    object.class.name
  end
  def following
    object.followed_by?(scope.current_user)
  end
end
