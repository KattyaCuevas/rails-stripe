class OrdersController < ApplicationController
  before_action :authenticate_user!

  def current
    @last_articles = Article.order(created_at: :desc).limit(3)
    @order = Order.where(user_id: current_user.id, status: 'created').last
    @order ||= Order.create(user_id: current_user.id)
    render :show
  end

  def show
    @last_articles = Article.order(created_at: :desc).limit(3)
    @order = Order.find(params[:id])
  end

  def checkout
    order = Order.find(params[:order_id])
    @intent = Stripe::PaymentIntent.create({ amount: order.total, currency: 'usd' })
  end
end
