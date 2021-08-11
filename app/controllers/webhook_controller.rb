class WebhookController < ApplicationController
  protect_from_forgery except: :receive

  def receive
    event_string = request.body.read
    event = Stripe::Event.construct_from(
      JSON.parse(event_string, symbolize_names: true)
    )
    object = event.data.object

    if ['payment_intent.succeeded', 'payment_intent.payment_failed'].include?(event.type)
      order = Order.find_by(stripe_payment_id: object.id)
      order.update(status: object.status)
    elsif event.type == 'checkout.session.completed'
      order = Order.find_by(stripe_checkout_id: object.id)
      order.user.update(stripe_customer_id: object.customer)
      order.update(status: object.payment_status)
    elsif event.type == 'customer.subscription.updated'
      order = User.find_by(stripe_customer_id: object.customer).orders.order(updated_at: :desc).first
      subscription = Subscription.find_by(stripe_pricing_id: object.plan.id)
      order.update(subscription: subscription)
    end

    render json: {}, status: 200
  end
end
