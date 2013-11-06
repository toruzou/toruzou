class CreateFollowing < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.references :user, index: true
      t.references :followable, index: true
      t.string :followable_type
    end
  end
end
