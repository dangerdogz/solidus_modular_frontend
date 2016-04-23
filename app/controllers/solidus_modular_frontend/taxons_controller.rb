require_dependency "solidus_modular_frontend/application_controller"

module SolidusModularFrontend
  class TaxonsController < ApplicationController
    def show
      @taxon = Spree::Taxon.find_by!(permalink: params[:id])
    end
  end
end
