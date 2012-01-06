class RemoveUrlFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :url
  end

  def down
    add_column :articles, :url, :string
  end
end
