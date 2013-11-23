class AddProjectTypeToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :project_type, :string
  end
end
