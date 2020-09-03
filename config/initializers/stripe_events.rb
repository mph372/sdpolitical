Stripe.api_key = Rails.application.credentials.stripe_api_key
StripeEvent.signing_secret = Rails.application.credentials.stripe_signing_secret

class UserUnsubscribed
    def call(event)
        event = event.data.object
        user = User.find_by(stripe_id: event.customer)
        user.update(stripe_subscription_id: nil)
        user.subscribed = false
        user.update(subscription_display: "You have cancelled your account. You will remain a subscriber until your current billing period ends.")
        user.update(cancellation_pending: true)
    end
end

class RecordCharges
    def call(event)
      charge = event.data.object
  
      # Look up the user in our database
      user = User.find_by(stripe_id: charge.customer)
  
      # Record a charge in our database
      c = user.charges.where(stripe_id: charge.id).first_or_create
      c.update(
        amount: charge.amount,
        card_last4: charge.source.last4,
        card_type: charge.source.brand,
        card_exp_month: charge.source.exp_month,
        card_exp_year: charge.source.exp_year
      )
    end
end

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.deleted', UserUnsubscribed.new
  events.subscribe 'charge.succeeded', RecordCharges.new
  end
