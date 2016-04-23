require_dependency "solidus_modular_frontend/application_controller"

module SolidusModularFrontend
  class ProductsController < ApplicationController
    def show
      @product = Spree::Product.find_by!(slug: params[:id])
    end
  end
end
