class ChangeAccuracyToInteger < ActiveRecord::Migration
  def change
    remove_column :deals, :accuracy
    add_column :deals, :accuracy, :integer
  end
end
