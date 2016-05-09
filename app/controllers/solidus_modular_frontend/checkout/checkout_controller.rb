require_dependency "solidus_modular_frontend/application_controller"

module SolidusModularFrontend
  module Checkout
    class CheckoutController < ApplicationController
      class OrderNotInStateError < StandardError
        def initialize(expected_state, actual_state)
          super("Expected order in #{expected_state}, was in #{actual_state}")
        end
      end

      include Spree::Core::ControllerHelpers::Auth
      include Spree::Core::ControllerHelpers::Order

      before_action do
        @order = current_order
      end

      private

      def current_step
        self.class.name.demodulize.gsub('Controller', '').downcase.to_sym
      end

      def next_step
        steps = Rails.application.config.checkout_steps
        # FIXME: make less awful
        next_step = steps.fetch(steps.find_index(current_step) + 1)
        if next_step == :complete
          checkout_order_complete_path(order_id: @order.to_param)
        else
          public_send "checkout_#{next_step}_path"
        end
      end
    end
  end
end
