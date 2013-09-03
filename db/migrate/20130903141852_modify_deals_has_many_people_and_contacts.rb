class ModifyDealsHasManyPeopleAndContacts < ActiveRecord::Migration
  def change
    remove_reference :deals, :person, index: true
    remove_reference :deals, :pm, index: true
    remove_reference :deals, :sales, index: true

    create_table :deals_people, id: false do |t|
      t.references :deal
      t.references :person
    end

    create_table :deals_users, id: false do |t|
      t.references :deal
      t.references :user
    end
  end
end
