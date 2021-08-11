class AddArticleIdsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :article_ids, :json
  end
end
