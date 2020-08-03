require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AgendaMail
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.assets.paths << Rails.root.join('vendor', 'assets')
    config.time_zone = 'Brasilia'
    config.i18n.default_locale = "pt-BR"
    config.i18n.available_locales = [:en, "pt-BR"]
    config.encoding = "utf-8"
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :patch, :options]
      end
    end

    config.middleware.use Rack::Attack
  end
end
