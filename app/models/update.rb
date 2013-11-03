class Update < ActiveRecord::Base

  belongs_to :audit, :class_name => "Auditable::Audit"
  belongs_to :receivable, :polymorphic => true

  scope :match_auditable, -> (auditable_type, auditable_id) {
    joins(:audit).where("audits.auditable_type = ?", auditable_type).where("audits.auditable_id = ?", auditable_id)
  }
  
end
