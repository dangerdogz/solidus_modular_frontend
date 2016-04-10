module SolidusModularFrontend
  class ApplicationController < ActionController::Base
    layout :selected_layout

    private

    def selected_layout
      Rails.application.config.solidus_modular_frontend[:layout]
    end
  end
end
