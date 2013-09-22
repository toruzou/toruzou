class ChangeRemarksToText < ActiveRecord::Migration
  def change
    change_column :careers, :remarks, :text
    change_column :contacts, :remarks, :text
  end
end
