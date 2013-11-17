class CreateSalesProjections < ActiveRecord::Migration
  def change
    create_table :sales_projections do |t|
      t.belongs_to :deal, index: true
      t.integer :year
      t.integer :period
      t.integer :amount
    end
  end
end
