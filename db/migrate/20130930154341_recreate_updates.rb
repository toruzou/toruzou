class RecreateUpdates < ActiveRecord::Migration
  def change
    drop_table :updates
    create_table :updates do |t|
      t.belongs_to :audit, index: true
      t.belongs_to :receivable, index: true, :polymorphic => true
      t.timestamps
    end
  end
end
