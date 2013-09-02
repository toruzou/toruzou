class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :organization_id
      t.integer :counter_person
      t.integer :pm
      t.integer :sales
      t.date :start_date
      t.date :order_date
      t.date :accept_date
      t.integer :amount
      t.string :accuracy
      t.string :status

      t.timestamps
    end
  end
end
