class Career < ActiveRecord::Base

  belongs_to :person
  has_many :attachments, :as => :attachable, :dependent => :delete_all

  audit :from_date, :to_date, :department, :title, :remarks

  after_destroy :destroy_updates

  def update_destinations_for(audit)
    self.person.update_destinations_for(audit)
  end

  def destroy_updates
    Update.match_auditable("Career", self.id).readonly(false).delete_all
  end
  
  include Comparable
  def <=> other
    return -1 unless to_date
    return 1 unless other.to_date
    return 0 if !to_date and !other.to_date
    other.to_date <=> to_date
  end

end
