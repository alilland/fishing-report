# frozen_string_literal: true

require 'rubygems'
require 'bundler'

## Dependencies
Bundler.require(:default)
Dotenv.load("./.env.#{ENV['RACK_ENV'] || 'development'}")

## Settings
require './settings'
require './init'

def log(level, taskname, message)
  Logger2.log(level, "#{taskname} - #{message}")
end

## Import rake tasks
Dir.glob('./tasks/**/*.rake') { |file| load file }
