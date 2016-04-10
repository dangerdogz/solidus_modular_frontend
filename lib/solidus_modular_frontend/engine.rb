module SolidusModularFrontend
  class Engine < ::Rails::Engine
    isolate_namespace SolidusModularFrontend

    config.generators do |g|
    end

    # FIXME: Make configurable
    paths['app/views'] = 'app/views/web-1.0'

    initializer "solidus.modular_frontend.configure" do |app|
      app.config.solidus_modular_frontend = {
        home: '/solidus_modular_frontend/home',
        layout: 'modular_frontend'
      }
    end
  end
end
