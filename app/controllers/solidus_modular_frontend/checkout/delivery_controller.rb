require_dependency "solidus_modular_frontend/checkout/checkout_controller"

module SolidusModularFrontend
  module Checkout
    class DeliveryController < CheckoutController
      before_action do
        fail(
          OrderNotInStateError.new('delivery', @order.state)
        ) unless @order.delivery?
      end

      def show
      end

      def update
        shipment_params.each do |shipment_id, rate_id|
          @order.shipments.find(shipment_id).selected_shipping_rate_id = rate_id
        end
        @order.next!
        redirect_to next_step
      end

      private

      def shipment_params
        params.require(:shipment)
      end
    end
  end
end

