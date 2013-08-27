class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|

      t.string :type
      t.string :name
      t.references :owner, index: true
      t.string :address
      t.string :remarks

      # Organization
      t.string :abbreviation
      t.string :url

      # Person
      t.references :organization, index: true
      t.string :phone
      t.string :email

      t.timestamps

    end
  end
end
