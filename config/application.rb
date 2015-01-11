require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ecomm
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true

    config.autoload_paths += Dir["#{config.root}/lib/"]

    config.assets.initialize_on_precompile = false
    # Precompile additional assets.
    # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    config.active_job.queue_adapter = :resque

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
