module Followable

  extend ActiveSupport::Concern

  included do

    has_many :followings, :as => :followable
    has_many :followers, :through => :followings, :source => :user

    def follow_by(user)
      Following.create(:user => user, :followable => self) unless followed_by?(user)
    end

    def unfollow_by(user)
      following = find_following_by(user)
      following.destroy if following.present?
    end

    def followed_by?(user)
      not find_following_by(user).nil?
    end

    def find_following_by(user)
      followings.find { |following| following.user == user }
    end

  end

end