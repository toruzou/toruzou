class AddPropertiesToSalesProjection < ActiveRecord::Migration
  def change
    add_column :sales_projections, :profit_amount, :decimal
    add_column :sales_projections, :profit_rate, :float
    add_column :sales_projections, :obic_no, :string
    add_column :sales_projections, :start_date, :date
    add_column :sales_projections, :end_date, :date
    add_column :sales_projections, :order_date, :date
  end

end
