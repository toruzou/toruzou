class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.references :activity, index: true
      t.references :participable, index: true
      t.string :participable_type
    end
  end
end
