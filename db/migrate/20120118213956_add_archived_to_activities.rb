class AddArchivedToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :archived, :boolean, :default => false, :null => false
  end
end
