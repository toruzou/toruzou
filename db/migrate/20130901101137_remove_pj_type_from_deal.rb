class RemovePjTypeFromDeal < ActiveRecord::Migration
  def change
    remove_column :deals, :pj_type
  end
end
