SolidusModularFrontend::Engine.routes.draw do
  root to: "#{Rails.application.config.solidus_modular_frontend[:home]}#index"
end
