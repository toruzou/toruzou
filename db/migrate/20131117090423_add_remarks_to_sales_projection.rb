class AddRemarksToSalesProjection < ActiveRecord::Migration
  def change
    add_column :sales_projections, :remarks, :text
  end
end
