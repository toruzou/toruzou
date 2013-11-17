class SalesProjection < ActiveRecord::Base

  belongs_to :deal
  
  default_scope { order(:year, :period) }
  scope :of, -> (deal_id) {
    where(:deal_id => deal_id)
  }

  audit :year, :period, :amount, :remarks

  after_destroy :destroy_updates

  def update_destinations_for(audit)
    self.deal.update_destinations_for(audit)
  end

  def destroy_updates
    Update.match_auditable("SalesProjection", self.id).readonly(false).delete_all
  end

  validates :period, :uniqueness => { :scope => :year }
  validates :amount,
    inclusion: { in: 0..(10 ** 11) },
    allow_nil: true,
    allow_blank: true

end
