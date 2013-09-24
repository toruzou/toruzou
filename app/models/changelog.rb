class Changelog < Update

  def add_change(change)
    self.changesets ||= []
    self.changesets << change.to_hash
  end

end
