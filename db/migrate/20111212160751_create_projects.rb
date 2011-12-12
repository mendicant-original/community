class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :user

      t.text :name,       :null => false
      t.text :description
      t.text :slug,       :null => false
      t.text :source_url

      t.boolean :core_project, :null => false, :default => false
      t.timestamps
    end
  end
end
