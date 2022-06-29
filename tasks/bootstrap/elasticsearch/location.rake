# frozen_string_literal: true

namespace :bootstrap do
  ##
  namespace :elasticsearch do
    ##
    task :location do |tn|
      log :debug, tn, 'start'
      file = File.join(APP_ROOT, 'config', 'location_mapping.json')
      mapping = JSON.parse(File.read(file))
      client = ES.client
      client.indices.delete index: ['locations'] if client.indices.exists? index: 'locations'
      client.indices.create index: 'locations', body: mapping
      log :info, tn, 'done'
    rescue StandardError => e
      log :fatal, tn, e.message
      log :fatal, tn, e.backtrace
      log :fatal, tn, JSON.parse(e.response[:body])
    end
  end
end
