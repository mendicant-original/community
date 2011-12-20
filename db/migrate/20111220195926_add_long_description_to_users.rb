class AddLongDescriptionToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :description, :short_description
    add_column    :users, :long_description, :text
  end
end
