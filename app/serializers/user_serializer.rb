class UserSerializer < ActivityAwareSerializer
  attributes :id, :name, :email, :last_sign_in_at, :last_sign_in_ip, :following
  def following
    object.followed_by?(scope.current_user)
  end
end
