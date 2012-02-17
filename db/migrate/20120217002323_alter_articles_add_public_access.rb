class AlterArticlesAddPublicAccess < ActiveRecord::Migration
  def up
    add_column(:articles, :public_access, :boolean, default: true)
  end

  def down
    remove_column(:articles, :public_access)
  end
end
