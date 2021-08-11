class UsersController < ApplicationController
  def profile
    @articles = Article.where(id: current_user.article_ids)
  end

  def billing_portal
    session = Stripe::BillingPortal::Session.create(
      { customer: current_user.stripe_customer_id, return_url: profile_url }
    )
    redirect_to session.url
  end
end
