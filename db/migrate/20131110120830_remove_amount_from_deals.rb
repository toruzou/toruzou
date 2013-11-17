class RemoveAmountFromDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :amount
  end
end
