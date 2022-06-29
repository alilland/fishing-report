# frozen_string_literal: true

## Database connection
env = (ENV['RACK_ENV'] || :development)
Mongoid.load!('./config/mongoid.yml', env)
