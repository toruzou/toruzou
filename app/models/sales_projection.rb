class SalesProjection < ActiveRecord::Base

  belongs_to :deal
  
  default_scope { joins(:deal).order(:year, :period) }
  scope :of, -> (deal_id) {
    where(:deal_id => deal_id)
  }
  scope :match_deal, -> (deal_name) {
    joins(:deal).where("lower(deals.name) LIKE ?", "%#{deal_name.downcase}%")
  }
  scope :match_project_types, -> (proejct_types) {
    joins(:deal).where("deals.project_type in (?)", proejct_types)
  }
  scope :match_categories, -> (categories) {
    joins(:deal).where("deals.category in (?)", categories)
  }
  scope :match_statuses, -> (statuses) {
    joins(:deal).where("deals.status in (?)", statuses)
  }
  scope :match_organization, -> (organization_name) {
    joins(:deal => :organization).where("lower(contacts.name) LIKE ?", "%#{organization_name.downcase}%")
  }
  scope :year_from, -> (from) {
    where("year >= #{from}")
  }
  scope :year_to, -> (to) {
    where("year <= #{to}")
  }

  audit :year, :period, :amount, :remarks

  after_destroy :destroy_updates

  def update_destinations_for(audit)
    self.deal.update_destinations_for(audit)
  end

  def destroy_updates
    Update.match_auditable("SalesProjection", self.id).readonly(false).delete_all
  end

  validates :period, :uniqueness => { :scope => [ :deal_id, :year ] }
  validates :amount,
    inclusion: { in: 0..(10 ** 11) },
    allow_nil: true,
    allow_blank: true
  validates :start_date,
    presence: true
  validates :end_date,
    presence: true
  validates :status,
    inclusion: Settings.with_defaults[:options][:deal_statuses].keys,
    allow_nil: true,
    allow_blank: true
  validates :accuracy,
    inclusion: [ 0, 25, 50, 75, 90, 100 ],
    allow_nil: true,
    allow_blank: true

end
