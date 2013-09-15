class Participant < ActiveRecord::Base
    belongs_to :activity
    belongs_to :participable, :polymorphic => true
end
