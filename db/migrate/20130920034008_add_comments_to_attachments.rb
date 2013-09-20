class AddCommentsToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :comments, :string
  end
end
