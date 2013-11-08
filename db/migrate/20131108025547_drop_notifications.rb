class DropNotifications < ActiveRecord::Migration
  def change
    drop_table :notifications
    add_column :updates, :type, :string
  end
end
