class AddPersonIdToCareers < ActiveRecord::Migration
  def change
    change_table :careers do |t|
      t.references :person, index: true
    end
  end
end
