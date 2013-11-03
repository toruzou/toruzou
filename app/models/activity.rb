class Activity < ActiveRecord::Base

  include Updatable

  acts_as_paranoid

  belongs_to :organization
  belongs_to :deal
  has_many :participants, :dependent => :destroy
  has_many :users, :through => :participants, :source => :participable, :source_type => 'User', :dependent => :delete_all
  has_many :people, :through => :participants, :source => :participable, :source_type => 'Contact', :dependent => :delete_all
  has_many :attachments, :as => :attachable, :dependent => :delete_all
  has_many :audits, :as => :auditable

  scope :in_organization, -> (organization_id) {
    where(organization_id: organization_id)
  }

  scope :in_deal, -> (deal_id) {
    where(deal_id: deal_id)
  }

  scope :match_subject, -> (subject) {
    where("lower(activities.subject) LIKE ?", "%#{subject.downcase}%")
  }

  scope :in_actions, -> (actions) {
    where(action: actions)
  }

  scope :match_deal, -> (deal_name) {
    joins(:deal).where("lower(deals.name) LIKE ?", "%#{deal_name.downcase}%")
  }

  scope :with_users, -> (users_ids) {
    joins(:users).where("users.id" => users_ids)
  }

  scope :with_people, -> (people_ids) {
    joins(:people).where("contacts.id" => people_ids)
  }

  scope :match_organization, -> (organization_name) {
    joins(:organization).where("lower(contacts.name) LIKE ?", "%#{organization_name.downcase}%")
  }

  scope :date_is, -> (term) {
    case term
    when "Overdue" then
      where("date < ?", Date.today)
    when "Last Week" then
      where(date: 1.week.ago.beginning_of_week..1.week.ago.end_of_week)
    when "Today" then
      where(date: Date.today)
    when "Tomorrow" then
      where(date: Date.tomorrow)
    when "This Week" then
      where(date: Date.today.beginning_of_week..Date.today.end_of_week)
    when "Next Week" then
      where(date: 1.week.since.beginning_of_week..1.week.since.end_of_week)
    end
  }

  scope :is_done, -> (done) {
    where(done: done)
  }


  validates :subject, presence: true
  validates :action, 
    inclusion: [ 'Call', 'Meeting', 'Email', 'Task' ],
    allow_nil: false,
    allow_blank: false

  validates :date, presence: true
  
end
