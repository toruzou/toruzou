class MoveAttrsFromDealToSales < ActiveRecord::Migration
  def change
    remove_column :deals, :status
    remove_column :deals, :accuracy
    remove_column :deals, :order_date

    add_column :sales_projections, :status, :string
    add_column :sales_projections, :accuracy, :integer
  end
end
