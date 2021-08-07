class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.text :body_preview
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
