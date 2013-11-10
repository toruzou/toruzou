class RenameActivitySubjectToName < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.rename :subject, :name
    end
  end
end
