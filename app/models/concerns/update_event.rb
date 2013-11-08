module UpdateEvent

  extend ActiveSupport::Concern

  included do
    after_create :publish
  end

  def publish
    return if self.latest_diff.empty?
    auditable = self.auditable
    if auditable.respond_to?(:filter_update_events_for)
      return unless auditable.filter_update_events_for(self)
    end
    destinations = []
    destinations << self.changed_by if self.changed_by.present?
    destinations += auditable.update_destinations_for(self) if auditable.respond_to?(:update_destinations_for)
    destinations = destinations.compact.uniq
    destinations.each do |receivable|
      Changelog.new(:audit => self, :receivable => receivable).save!
    end
    destinations.each do |receivable|
      if receivable.respond_to?(:followers)
        receivable.followers.compact.uniq.each do |follower|
          Notification.new(:audit => self, :receivable => follower).save!
        end
      end
    end
  end

end