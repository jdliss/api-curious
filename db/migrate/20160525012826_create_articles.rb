class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title
      t.text :abstract
      t.text :url
      t.string :section

      t.timestamps null: false
    end
  end
end
