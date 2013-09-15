class ChangeDealsAssociations < ActiveRecord::Migration
  def change
    drop_table :deals_people
    drop_table :deals_users
    change_table :deals do |t|
      t.references :pm, index: true
      t.references :sales, index: true
      t.references :contact, index: true
    end
  end
end
