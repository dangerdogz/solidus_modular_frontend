require_dependency "solidus_modular_frontend/application_controller"

module SolidusModularFrontend
  module Checkout
    class CheckoutController < ApplicationController
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
        public_send "checkout_#{steps.fetch(steps.find_index(current_step) + 1)}_path"
      end
    end
  end
end
