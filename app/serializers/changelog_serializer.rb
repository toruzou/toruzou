class ChangelogSerializer < UpdateSerializer
  attributes :changesets
  def changesets
    object.changesets.to_json
  end
end
