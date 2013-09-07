class RenameTypeToAction < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.rename :type, :action
    end
  end
end
