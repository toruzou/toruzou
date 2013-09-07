class AddNameToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :name, :string
  end
end
