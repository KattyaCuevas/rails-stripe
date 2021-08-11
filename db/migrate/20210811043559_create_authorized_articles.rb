class CreateAuthorizedArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :authorized_articles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.string :authorization_type

      t.timestamps
    end
  end
end
