class Update < ActiveRecord::Base

  belongs_to :audit, :class_name => "Auditable::Audit"
  belongs_to :receivable, :polymorphic => true

  scope :match_receivable, -> (receivable_type, receivable_id) {
    where(:receivable_type => receivable_type, :receivable_id => receivable_id)
  }

  scope :match_auditable, -> (auditable_type, auditable_id) {
    joins(:audit).where("audits.auditable_type = ?", auditable_type).where("audits.auditable_id = ?", auditable_id)
  }
  
end
