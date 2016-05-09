require_dependency "solidus_modular_frontend/checkout/checkout_controller"

module SolidusModularFrontend
  module Checkout
    class PaymentController < CheckoutController
      before_action do
        fail(
          OrderNotInStateError.new('payment', @order.state)
        ) unless @order.payment?
      end

      def show
      end

      def update
        #FIXME: Invalidate old payments
        payment_method_params.each do |payment_method_id, source_params|
          source = Spree::PaymentMethod.find(
            payment_method_id
          ).payment_source_class.new(
            source_params.permit(%i(
              name
              number
              month
              year
              verification_value
            ))
          )
          @order.payments.create!(
            amount: @order.total,
            source: source,
            payment_method_id: payment_method_id
          )
        end
        @order.next!
        redirect_to next_step
      end

      private

      def payment_method_params
        params.require(:payment_method)
      end
    end
  end
end
