class CheckoutController < ApplicationController
  def create
    if params[:type] == 'subscription'
      create_subscription_session
    else
      create_payment_session
    end
  end

  private

  def create_subscription_session
    subscription = Subscription.find(params[:subscription_id])
    session = Stripe::Checkout::Session.create(
      {
        payment_method_types: ['card'],
        line_items: [{ price: subscription.stripe_pricing_id, quantity: 1 }],
        mode: 'subscription',
        success_url: articles_url,
        cancel_url: subscriptions_url
      }
    )
    Order.create(order_type: 'subscription', stripe_checkout_id: session.id, user: current_user,
                 subscription: subscription)
    redirect_to session.url
  end

  def create_payment_session
    order = Order.find(params[:order_id])
    articles_per_price = order.articles.joins(:category)
                              .select('categories.stripe_pricing_id, articles.id, articles.title')
                              .group_by(&:stripe_pricing_id)
    pricing_list = articles_per_price.map do |key, value|
      { price: key, quantity: value.size, description: value.pluck(:title).join(', ') }
    end

    session = Stripe::Checkout::Session.create(
      {
        payment_method_types: ['card'],
        line_items: pricing_list,
        mode: 'payment',
        success_url: articles_url,
        cancel_url: order_url(order)
      }
    )
    order.update!(stripe_payment_id: session.payment_intent)
    redirect_to session.url
  end
end
