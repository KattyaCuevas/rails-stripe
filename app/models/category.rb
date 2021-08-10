class Category < ApplicationRecord
  after_create :create_stripe_product

  def create_stripe_product
    product = Stripe::Product.create(name: name)
    pricing = Stripe::Price.create(
      unit_amount: price,
      currency: 'usd',
      product: product.id
    )
    update(stripe_pricing_id: pricing.id, stripe_product_id: product.id)
  end 
end
