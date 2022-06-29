# frozen_string_literal: true

##
module FR
  ## Configuration
  Dir.glob('./config/**/*.rb') { |file| load file }

  ## Library
  Dir.glob('./lib/**/*.rb') { |file| load file }

  ## Models
  Dir.glob('./models/**/*.rb') { |file| load file }

  ##
  class API < Grape::API
    use Rack::JSONP
    content_type :json, 'application/json'
    default_format :json

    get '/' do
      error! 'Bad Request', 400 if params.keys.length.positive?
      present :root, { api_name: 'fishing-report', version: 'v1' }, with: Grape::Presenters::Presenter
    end
  end
end
