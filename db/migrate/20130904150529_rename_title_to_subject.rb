class RenameTitleToSubject < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.rename :title, :subject
    end
  end
end
