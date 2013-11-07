module Followable

  extend ActiveSupport::Concern

  included do

    has_many :followings, :as => :followable
    has_many :followers, :through => :followings, :source => :user

    def follow_by(user)
      self.followers << user unless followed_by?(user)
      self
    end

    def unfollow_by(user)
      self.followers.delete(user) if followed_by?(user)
      self
    end

    def followed_by?(user)
      not self.followers.find { |follower| follower == user }.nil?
    end

  end

end