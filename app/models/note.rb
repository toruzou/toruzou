class Note < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :subject, :polymorphic => true
  has_many :audits, :as => :auditable

  audit :message

  after_destroy :destroy_updates

  def update_destinations_for(audit)
    self.subject.update_destinations_for(audit)
  end

  def filter_update_events_for(audit)
    audit.action == "create"
  end

  def destroy_updates
    Update.match_auditable("Note", self.id).readonly(false).delete_all
  end
  
end
