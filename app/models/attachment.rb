class Attachment < ActiveRecord::Base
  
  mount_uploader :attachment, AttachmentUploader
  belongs_to :attachable, :polymorphic => true

  audit :name
  
  after_destroy :destroy_updates

  def update_destinations_for(audit)
    [ self.attachable ]
  end

  def destroy_updates
    Update.match_auditable("Attachment", self.id).readonly(false).delete_all
  end

end
