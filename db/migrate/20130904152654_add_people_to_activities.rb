class AddPeopleToActivities < ActiveRecord::Migration
  def change
    create_table :activities_people, id: false do |t|
      t.references :activity
      t.references :person
    end
  end
end
