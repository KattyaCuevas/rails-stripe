class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders

  def subscribed?
    Order.where(user_id: id, order_type: 'subscription', status: 'paid').any?
  end

  def subscription
    Order.where(user_id: id, order_type: 'subscription', status: 'paid').order(updated_at: :desc).first&.subscription
  end

  def subscribed_articles_this_month
    AuthorizedArticle.where(user_id: id, authorization_type: 'subscription').where(created_at: Date.today.beginning_of_month..Date.today.end_of_month)
  end

  def remaining_articles
    subscription.number - subscribed_articles_this_month.count
  end
end
