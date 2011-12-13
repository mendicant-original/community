class CreateLearningMaterials < ActiveRecord::Migration
  def change
    create_table :learning_materials do |t|
      t.text :name
      t.text :description
      t.text :url
      t.text :slug

      t.timestamps
    end
  end
end
