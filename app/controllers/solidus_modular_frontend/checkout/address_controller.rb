require_dependency "solidus_modular_frontend/checkout/checkout_controller"

module SolidusModularFrontend
  module Checkout
    class AddressController < CheckoutController
      before_action only: :show do
        @order.state = 'cart'
        @order.save!
      end

      before_action do
        # FIXME: Actually do this
        @order.email = 'test@test.com'
        @billing_address = @order.billing_address || Spree::Address.new
        @shipping_address = @order.shipping_address || Spree::Address.new
        @order.next! if @order.state == 'cart'
        fail(
          OrderNotInStateError.new('address', @order.state)
        ) unless @order.address?
      end

      # FIXME: Add some basic error handling
      def create
        @billing_address.update(address_params)
        @shipping_address.update(address_params)
        assign_addresses
        @order.next!
        redirect_to next_step
      end

      # FIXME: Add some basic error handling
      def update
        # TODO: Only change the address if the address has changed
        @billing_address = Spree::Address.create!(address_params)
        @shipping_address = Spree::Address.create!(address_params)
        assign_addresses
        @order.next!
        redirect_to next_step
      end

      def show
      end

      private

      def address_params
        params.require(:address).permit(%i(
          firstname
          lastname
          address1
          address2
          city
          zipcode
          phone
          state_id
          country_id
        ))
      end

      def assign_addresses
        @order.ship_address = @shipping_address
        @order.bill_address = @billing_address
        @order.save!
      end
    end
  end
end
