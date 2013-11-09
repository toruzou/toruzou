class Following < ActiveRecord::Base

  belongs_to :user
  belongs_to :followable, :polymorphic => true

  scope :of, -> (user) {
    where(:user_id => user.id)
  }

end
