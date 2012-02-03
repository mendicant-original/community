class CreateDiscussionLists < ActiveRecord::Migration
  def change
    create_table :discussion_lists do |t|
      t.belongs_to :activity
      t.text       :name

      t.timestamps
    end
  end
end
