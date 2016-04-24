SolidusModularFrontend::Engine.routes.draw do
  def config_template(type, ns = nil)
    if ns
      "#{Rails.application.config.solidus_modular_frontend[ns][type]}"
    else
      "#{Rails.application.config.solidus_modular_frontend[type]}"
    end
  end

  resource :cart, controller: config_template(:cart), only: %i(show) do
    post :add
  end
  resources :products, controller: config_template(:products), only: %i(show)
  resources :taxons, controller: config_template(:taxons), only: %i(show)

  namespace :checkout do
    resource(
      :address,
      controller: config_template(:address, :checkout),
      only: %i(create show update)
    )
    resource(
      :delivery,
      controller: config_template(:delivery, :checkout),
      only: %i(show update)
    )
    resource(
      :payment,
      controller: config_template(:payment, :checkout),
      only: %i(show update)
    )
    resource(
      :confirm,
      controller: config_template(:confirm, :checkout),
      only: %i(show create)
    )
    resource(
      :complete,
      controller: config_template(:complete, :checkout),
      only: %i(show)
    )
  end

  root to: "#{config_template(:home)}#index"
end
