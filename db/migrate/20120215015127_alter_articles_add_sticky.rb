class AlterArticlesAddSticky < ActiveRecord::Migration
  def up
    add_column(:articles, :sticky, :boolean, default: false)
  end

  def down
    remove_column(:articles, :sticky)
  end
end
