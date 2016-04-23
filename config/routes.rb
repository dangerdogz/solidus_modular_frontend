SolidusModularFrontend::Engine.routes.draw do
  def config_template(type)
    "#{Rails.application.config.solidus_modular_frontend[type]}"
  end

  resource :cart, controller: config_template(:cart), only: %i(show) do
    post :add
  end
  resources :products, controller: config_template(:products), only: %i(show)
  resources :taxons, controller: config_template(:taxons), only: %i(show)

  root to: "#{config_template(:home)}#index"
end
