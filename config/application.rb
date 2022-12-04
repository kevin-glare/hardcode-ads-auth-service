# frozen_string_literal: true

require 'sinatra/custom_logger'

class Application < Sinatra::Base
  use Rack::JSONBodyParser
  
  helpers Sinatra::CustomLogger
  helpers Validations

  configure do
    register Sinatra::Namespace
    register ApiErrors
    set :app_file, File.expand_path(__dir__)
    set :default_content_type, :json
  end

  configure :development do
    register Sinatra::Reloader

    set :show_exceptions, false
  end
end
