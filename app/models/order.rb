class Order < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :articles, through: :order_items
  belongs_to :subscription, optional: true

  # Callbacks
  after_save :add_articles_to_user, if: :paid_order?

  private

  def paid_order?
    status == 'succeeded'
  end

  def add_articles_to_user
    order_items.pluck(:article_id).map do |article_id|
      AuthorizedArticle.create(user: user, article_id: article_id, authorization_type: 'paid')
    end
  end
end
