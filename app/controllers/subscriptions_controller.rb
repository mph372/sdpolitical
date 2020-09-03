class SubscriptionsController < ApplicationController
    layout "subscribe"
    before_action :authenticate_user!, except: [:new, :create]


    
    def new

      set_meta_tags title: 'Subscribe',
      site: 'The Ballot Book'
      
        if user_signed_in? && current_user.subscribed?
            redirect_to root_path, notice: "You are already a subscriber"
        end
    end

    def create
        Stripe.api_key = Rails.application.credentials.stripe_api_key

        plan_id = params[:plan_id]
        plan = Stripe::Plan.retrieve(plan_id)
        token = params[:stripeToken]
        customer = if current_user.stripe_id?
                    Stripe::Customer.retrieve(current_user.stripe_id)
                    else
                        Stripe::Customer.create(email: current_user.email, source: token)
                    end
        subscription = customer.subscriptions.create(plan: plan.id)

        options = {
            stripe_id: customer.id,
            stripe_subscription_id: subscription.id,
            subscribed: true
        }

        options.merge!(
            card_last4: params[:user][:card_last4],
            card_exp_month: params[:user][:card_exp_month],
            card_exp_year: params[:user][:card_exp_year],
            card_type: params[:user][:card_type]
          ) if params[:user][:card_last4]

        current_user.update(options)

        redirect_to root_path, notice: "Your subscription was setup successfully!"  
    end

    def destroy
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer_subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
      Stripe::Subscription.update(
        customer_subscription.id,
        {
          cancel_at_period_end: true
        }
      )
      current_user.update(subscription_display: "You have cancelled your account. You will remain a subscriber until your current billing period ends.")
      current_user.update(cancellation_pending: true)
  
  
      redirect_to '/users/edit', notice: "You have cancelled your account. You will remain a subscriber until your current billing period ends."
    end
end
