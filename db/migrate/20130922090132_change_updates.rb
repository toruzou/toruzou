class ChangeUpdates < ActiveRecord::Migration
  def up
    drop_table :updates
    create_table :updates do |t|
      t.string :type
      t.references :user, index: true
      t.string :subject_type
      t.integer :subject_id
      t.string :action
      t.text :message
      t.hstore :changesets, array: true
      t.timestamps
    end
  end
  def down
    drop_table :updates
    create_table :updates do |t|
      t.string   "type"
      t.date     "timestamp"
      t.string   "message"
      t.string   "subject_type"
      t.integer  "subject_id"
      t.string   "action"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.references :user, index: true
      t.references :activity, index: true
    end
  end
end
