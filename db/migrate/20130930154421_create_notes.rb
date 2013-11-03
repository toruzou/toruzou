class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.belongs_to :subject, :polymorphic => true
      t.text :message
    end
  end
end
