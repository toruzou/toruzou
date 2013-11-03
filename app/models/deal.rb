class Deal < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :organization
  belongs_to :pm, :class_name => "User"
  belongs_to :sales, :class_name => "User"
  belongs_to :contact, :class_name => "Person"
  has_many :activities
  has_many :attachments, :as => :attachable
  has_many :updates, :as => :receivable
  has_many :audits, :as => :auditable

  scope :in_organization, -> (organization_id) {
    where(:organization_id => organization_id)
  }

  scope :match_name, -> (q) {
    where("lower(deals.name) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_status, -> (q) {
    where(status: q)
  }

  scope :match_organization, -> (q) {
    joins(%(INNER JOIN "contacts" as "organization" ON "organization"."id" = "deals"."organization_id" AND "organization"."type" IN ('Organization'))).where("lower(organization.name) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_pm, -> (q) {
    joins(%(INNER JOIN "users" as "pm" ON "pm"."id" = "deals"."pm_id")).where("lower(pm.name) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_sales, -> (q) {
    joins(%(INNER JOIN "users" as "sales" ON "sales"."id" = "deals"."sales_id")).where("lower(sales.name) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_contact, -> (q) {
    joins(%(INNER JOIN "contacts" as "contact" ON "contact"."id" = "deals"."contact_id" AND "contact"."type" IN ('Person'))).where("lower(contact.name) LIKE ?", "%#{q.downcase}%")
  }

  scope :match_user, -> (q) {
    condition = Deal.arel_table[:pm_id].eq(q)
    condition = condition.or(Deal.arel_table[:sales_id].eq(q))
    where(condition)
  }
  
  validates :name, presence: true

  # TODO decide valid combination of status and accuracy.
  validates :status,
    inclusion: [ 'Plan', 'Proposal', 'In Negotiation', 'Won', 'Lost' ],
    allow_nil: true,
    allow_blank: true
  validates :accuracy,
    inclusion: [ 0, 25, 50, 75, 90, 100 ],
    allow_nil: true,
    allow_blank: true
  validates :amount,
    inclusion: { in: 0..(10 ** 11) },
    allow_nil:true,
    allow_blank: true

  audit :name, :organization, :pm, :sales, :contact, :status, :amount, :accuracy, :start_date, :order_date, :accept_date

  def update_destinations_for(audit)
    [ self, self.organization ]
  end

end
