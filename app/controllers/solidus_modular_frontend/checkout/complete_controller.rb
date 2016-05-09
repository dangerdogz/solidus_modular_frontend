require_dependency "solidus_modular_frontend/checkout/checkout_controller"

module SolidusModularFrontend
  module Checkout
    class CompleteController < CheckoutController
      before_action do
        # FIXME: Make sure this is one of my orders
        @order = Spree::Order.find_by!(number: params[:order_id])
        fail(
          OrderNotInStateError.new('complete', @order.state)
        ) unless @order.complete?
      end

      def show
      end
    end
  end
end

