class RenameCareerColumns < ActiveRecord::Migration
  def change
    change_table :careers do |t|
      t.rename :from, :from_date
      t.rename :to, :to_date
    end
  end
end
