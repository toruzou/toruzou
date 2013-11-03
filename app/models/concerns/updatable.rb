module Updatable

  extend ActiveSupport::Concern

  included do
    after_create :save_updates
  end

  def save_updates
    auditable = self.auditable
    if auditable.respond_to?(:filter_update_events_for)
      return unless auditable.filter_update_events_for(self)
    end
    destinations = []
    destinations << self.changed_by if self.changed_by.present?
    destinations += auditable.update_destinations_for(self) if auditable.respond_to?(:update_destinations_for)
    destinations.compact.uniq.each do |receivable|
      Update.new(:audit => self, :receivable => receivable).save!
    end
  end

  def update_destinations_for(audit)
    [ audit.changed_by ]
  end

end