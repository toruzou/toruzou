class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachable, index: true
      t.string :attachable_type
      t.column :attachment, :oid, :null => false
      t.string :name
      t.string :content_type
      t.timestamps
    end
  end
end
