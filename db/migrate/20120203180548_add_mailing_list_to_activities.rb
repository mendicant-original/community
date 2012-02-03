class AddMailingListToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :allow_discussion, :boolean, :null => false, :default => false
    add_column :activities, :discussion_list_name, :text
  end
end
