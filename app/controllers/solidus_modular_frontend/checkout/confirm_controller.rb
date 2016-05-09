require_dependency "solidus_modular_frontend/checkout/checkout_controller"

module SolidusModularFrontend
  module Checkout
    class ConfirmController < CheckoutController
      before_action do
        fail(
          OrderNotInStateError.new('confirm', @order.state)
        ) unless @order.confirm?
      end

      def show
      end

      def create
        # FIXME: This should be more generic
        @order.complete!
        redirect_to next_step
      end
    end
  end
end
