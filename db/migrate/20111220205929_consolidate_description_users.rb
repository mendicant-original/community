class ConsolidateDescriptionUsers < ActiveRecord::Migration
  def change
    rename_column :users, :long_description, :description
    remove_column :users, :short_description
  end
end
