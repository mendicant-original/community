class AddPostedToTwitterToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :posted_to_twitter, :boolean, :default => false, :null => false
  end
end
