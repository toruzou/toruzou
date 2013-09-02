class ChangeColumnToUseReference < ActiveRecord::Migration
  def up
    remove_column :activities, :deal_id, :integer
    add_reference :activities, :deal, index: true

    remove_column :deals, :organization_id, :integer
    add_reference :deals, :organization, index: true
    
    remove_column :deals, :counter_person, :integer
    add_reference :deals, :person, index: true
    
    remove_column :deals, :pm, :integer
    add_reference :deals, :pm, index: true
    
    remove_column :deals, :sales, :integer
    add_reference :deals, :sales, index: true
    
    remove_column :updates, :user_id, :integer
    add_reference :updates, :user, index: true
    
    remove_column :updates, :activity_id, :integer
    add_reference :updates, :activity, index: true
    
  end

  def down
    remove_reference :activities, :deal, index: true
    add_column :activities, :deal_id, :integer

    remove_reference :deals, :organization, index: true
    add_column :deals, :organization_id, :integer
    
    remove_reference :deals, :person, index: true
    add_column :deals, :counter_person, :integer

    remove_reference :deals, :pm, index: true
    add_column :deals, :pm, :integer

    remove_reference :deals, :sales, index: true
    add_column :deals, :sales, :integer

    remove_reference :updates, :user, index: true
    add_column :updates, :user_id, :integer
    
    remove_reference :updates, :activity, index: true
    add_column :updates, :activity_id, :integer
    
  end
end
