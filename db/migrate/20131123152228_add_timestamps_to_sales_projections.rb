class AddTimestampsToSalesProjections < ActiveRecord::Migration
  def change
    add_column :sales_projections, :created_at, :datetime
    add_column :sales_projections, :updated_at, :datetime
  end
end
