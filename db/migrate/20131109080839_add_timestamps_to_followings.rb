class AddTimestampsToFollowings < ActiveRecord::Migration
  def change
    add_column :followings, :created_at, :datetime
    add_column :followings, :updated_at, :datetime
  end
end
