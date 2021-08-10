class Order < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :articles, through: :order_items

  # Callbacks
  after_save :add_articles_to_user, if: :paid_order?

  private

  def paid_order?
    status == 'succeeded'
  end

  def add_articles_to_user
    user.article_ids += order_items.pluck(:article_id)
    user.save
  end
end