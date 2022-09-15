class CheckoutController < ApplicationController

    def create
        if Rails.env.production?
            @session = Stripe::Checkout::Session.create({
                customer: current_user.stripe_customer_id,
                success_url: posts_url,
                cancel_url: pricing_url,
                payment_method_types: ['card'],
                line_items: [
                {price: params[:price], quantity: 1},
                ],
                mode: 'subscription',
            })
            respond_to do |format|
                format.js
            end
        elsif Rails.env.development?
            @session = Stripe::Checkout::Session.create({
                customer: current_user.stripe_customer_id,
                payment_method_types: ['card'],
                line_items: [
                {price: params[:price], quantity: 1},
                ],
                mode: 'subscription',
                success_url: posts_url + "?session_id={CHECKOUT_SESSION_ID}",
                cancel_url: pricing_url,
            })
            redirect_to @session.url
        end
    end
  end

 