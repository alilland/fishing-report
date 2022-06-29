# frozen_string_literal: true

# Dependencies
require 'bundler'
require 'json'

Bundler.require :default
Dotenv.load("./.env.#{ENV['RACK_ENV'] || 'development'}")

# Main application files
require './init'

## CORS
require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post options put delete patch]
  end
end

# enable gzip
use Rack::Deflater

## Run Application
run Rack::Cascade.new [FR::API]

# sudo service mongod start
# bundle exec rackup -p 8080 --host 172.22.10.83
##
