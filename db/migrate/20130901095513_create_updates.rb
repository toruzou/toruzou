class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :type
      t.date :timestamp
      t.integer :user_id
      t.string :message
      t.string :subject_type
      t.integer :subject_id
      t.integer :activity_id
      t.string :update_type

      t.timestamps
    end
  end
end
