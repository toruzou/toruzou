class AddOrganizationToActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.references :organization, index: true
    end
  end
end
