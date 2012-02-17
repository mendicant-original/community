class AlterArticlesAddPublicAccess < ActiveRecord::Migration
  def up
    add_column(:articles, :public, :boolean, default: true)
  end

  def down
    remove_column(:articles, :public)
  end
end
