class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer  :author_id
      t.boolean  :highlight
      t.string   :url
      t.string   :title
      t.text     :body

      t.timestamps
    end
  end
end
