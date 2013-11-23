class Settings < RailsSettings::CachedSettings

  def self.with_defaults
    self.defaults.merge(self.all)
  end

end
