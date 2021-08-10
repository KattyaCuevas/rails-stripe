class WebhookController < ApplicationController
  protect_from_forgery except: :receive

  def receive
    event_string = request.body.read
    event = Stripe::Event.construct_from(
      JSON.parse(event_string, symbolize_names: true)
    )

    if event.type.include?('payment_intent')
      payment = event.data.object
      order = Order.find_by(stripe_payment_id: payment.id)
      order.update(status: payment.status)
    end

    render json: {}, status: 200
  end
end
