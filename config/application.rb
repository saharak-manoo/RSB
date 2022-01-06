require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RSB
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    Dir[Rails.root.join('lib', 'extensions', '**', '*.rb')].each { |f| require f }
    config.autoload_paths <<  Rails.root.join("lib")

    config.time_zone = 'Bangkok'
    config.i18n.default_locale = :th
  end
end
