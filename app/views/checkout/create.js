var stripe = Stripe("<%= Rails.env.prodcution? ? ENV['STRIPE_PUBLIC'] : Rails.application.credentials[:stripe][:public] %>");

stripe.redirectToCheckout({
  sessionId: '<%= @session.id %>'
}).then(function (result) {
  console.log(result.error.message);
});