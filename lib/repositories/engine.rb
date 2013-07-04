require 'repositories_home_helper_patch'
module Repositories
  class Engine < ::Rails::Engine
    engine_name 'repositories'

    initializer "repositories_engine.load_app_instance_data" do |app|
      app.config.paths['db/migrate'] += Repositories::Engine.paths['db/migrate'].existent
    end

    # Include extensions to models in this config.to_prepare block
    config.to_prepare do
      # Patch the menu
      ::HomeHelper.send :include, RepositoriesHomeHelperPatch
    end
  end
end
