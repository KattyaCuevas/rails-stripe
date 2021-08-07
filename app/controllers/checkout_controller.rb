class CheckoutController < ApplicationController
  def create
    order = Order.find(params[:order_id])
    pricing_list = order.articles.map do |article|
      { price: article.stripe_pricing_id, description: article.title, quantity: 1 }
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
    redirect_to session.url
  end
end
