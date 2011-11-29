class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name,      :null => false
      t.string  :email

      t.string  :github
      t.integer :github_id
      t.string  :uid

      t.string  :twitter
      t.string  :website
      t.string  :description

      t.boolean :admin, :default => false, :null => false

      t.timestamps
    end
  end
end
