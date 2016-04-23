require_dependency "solidus_modular_frontend/application_controller"

module SolidusModularFrontend
  class CartController < ApplicationController
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Order

    def add
      variant = Spree::Variant.find(add_params[:variant_id])
      order_contents.add(variant, add_params[:quantity])
      redirect_to action: :show
    end

    def show
    end

    private

    def order
      current_order(create_order_if_necessary: true)
    end

    def order_contents
      @order_contents ||= Spree::OrderContents.new(order)
    end

    def add_params
      params.permit(:variant_id, :quantity)
    end
  end
end
