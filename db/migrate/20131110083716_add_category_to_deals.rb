class AddCategoryToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :category, :string
  end
end
