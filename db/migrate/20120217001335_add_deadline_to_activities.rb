class AddDeadlineToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :deadline, :datetime
  end
end
