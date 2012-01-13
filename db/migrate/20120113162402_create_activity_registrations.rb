class CreateActivityRegistrations < ActiveRecord::Migration
  def change
    create_table :activity_registrations do |t|
      t.belongs_to :user
      t.belongs_to :activity

      t.boolean    :approved, :null => false

      t.timestamps
    end
  end
end
