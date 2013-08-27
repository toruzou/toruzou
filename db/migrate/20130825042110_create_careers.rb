class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.date :from
      t.date :to
      t.string :department
      t.string :title
      t.string :remarks

      t.timestamps
    end
  end
end
