# frozen_string_literal: true

class Configurable
  extend Dry::Configurable

  setting :app do
    setting :name, default: 'auth'
  end

  setting :i18n do
    setting :default_locale, default: :ru
    setting :available_locales, default: %i[en ru]
  end

  setting :db do
    setting :adapter, default: ENV.fetch('DB_ADAPTER', 'postgresql')
    setting :pool, default: ENV.fetch('DB_POOL', 5)
    setting :host, default: ENV.fetch('DB_HOST', 'localhost')
    setting :port, default: ENV.fetch('DB_PORT', 5432)
    setting :user, default: ENV.fetch('DB_USER', nil)
    setting :password, default: ENV.fetch('DB_PASSWORD', nil)
    setting :database, default: ENV.fetch('DB_DATABASE')
  end

  setting :secret_key_base, default: ENV.fetch('SECRET_KEY_BASE')

  setting :rabbit_mq do
    setting :consumer_pool, default: ENV.fetch('RABBIT_MQ_CONSUMER_POOL', 2)
  end

  setting :logger do
    setting :path, default: 'log/app.log'
    setting :level, default: 'info'
  end
end

AppSetting = Configurable.config.freeze
