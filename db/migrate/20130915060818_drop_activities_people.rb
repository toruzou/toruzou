class DropActivitiesPeople < ActiveRecord::Migration
  def change
    drop_table :activities_people
  end
end
