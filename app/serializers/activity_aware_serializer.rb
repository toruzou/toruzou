# TODO Refactoring

class SimpleUserSerializer < ActiveModel::Serializer
  attributes :id, :name
end

class SimpleActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :action, :date, :note, :done
  has_many :users, serializer: SimpleUserSerializer
  def users
    User.joins(:participants).select(["users.id", "users.name"]).where(%("participants"."activity_id" = #{self.id})).order("name")
  end
end

class ActivityAwareSerializer < ActiveModel::Serializer
  has_one :next_activity, serializer: SimpleActivitySerializer
  has_one :last_activity, serializer: SimpleActivitySerializer
  def include_associations!
    if scope.controller.action_name == "show"
      include! :next_activity
      include! :last_activity
    end
  end
  def next_activity
    object.activities.where("date >= ?", Date.today).order("date ASC, done ASC, updated_at DESC").limit(1).first
  end
  def last_activity
    relation = object.activities.where("date <= ?", Date.today)
    relation = relation.where.not(:id => next_activity[:id]) if next_activity.present?
    relation.order("date DESC, done DESC, updated_at DESC").limit(1).first
  end
end
