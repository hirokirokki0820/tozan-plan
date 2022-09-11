require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# module TozanPlan
module TozanPlan
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.time_zone = "Tokyo"
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # config.eager_load_paths << Rails.root.join("extras")
    # config.eager_load_paths += %W(#{Rails.root}/app/assets/pdfs)
    config.paths.add 'app/assets/pdfs', eager_load: true

    # Active Record の暗号化キー設定
    config.active_record.encryption.primary_key = ENV['PRIMARY_KEY']
    config.active_record.encryption.deterministic_key = ENV['DETERMINISTIC_KEY']
    config.active_record.encryption.key_derivation_salt = ENV['KEY_DERIVATION_SALT']
  end
end
