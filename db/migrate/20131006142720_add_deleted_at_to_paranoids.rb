class AddDeletedAtToParanoids < ActiveRecord::Migration
  def change
    add_column :activities, :deleted_at, :timestamp
    add_column :deals, :deleted_at, :timestamp
    add_column :contacts, :deleted_at, :timestamp
  end
end
