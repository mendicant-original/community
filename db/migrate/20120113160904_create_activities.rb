class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :author_id
      t.string  :title
      t.string  :slug
      t.text    :body

      t.boolean :registration_open,       :null => false
      t.boolean :participation_moderated, :null => false

      t.timestamps
    end
  end
end
