class Attachment < ActiveRecord::Base
  
  mount_uploader :attachment, AttachmentUploader
  belongs_to :attachable, :polymorphic => true

  audit :name
  
  after_destroy :destroy_updates

  def attachable
    # Handle paranoids
    self.attachable_type.constantize.unscoped.find(self.attachable_id)
  end

  def filter_update_events_for(audit)
    audit.action == "create"
  end

  def update_destinations_for(audit)
    self.attachable.update_destinations_for(audit)
  end

  def destroy_updates
    Update.match_auditable("Attachment", self.id).readonly(false).delete_all
  end

end
