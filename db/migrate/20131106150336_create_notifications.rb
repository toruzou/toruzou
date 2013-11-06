class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true
      t.belongs_to :audit, index: true
      t.timestamps
    end
  end
end
