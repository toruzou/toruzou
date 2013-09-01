class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.date :date
      t.text :note
      t.boolean :done

      t.timestamps
    end
  end
end
