class Career < ActiveRecord::Base

  has_many :attachments, :as => :attachable, :dependent => :delete_all

  include Comparable
  def <=> other
    return -1 unless to_date
    return 1 unless other.to_date
    return 0 if !to_date and !other.to_date
    other.to_date <=> to_date
  end

end
