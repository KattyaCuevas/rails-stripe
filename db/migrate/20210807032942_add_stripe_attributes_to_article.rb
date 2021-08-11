class AddStripeAttributesToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :stripe_pricing_id, :string
    add_column :articles, :stripe_product_id, :string
  end
end
