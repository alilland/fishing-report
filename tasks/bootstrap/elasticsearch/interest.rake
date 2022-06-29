# frozen_string_literal: true

namespace :bootstrap do
  ##
  namespace :elasticsearch do
    ##
    task :interest do |tn|
      log :debug, tn, 'start'
      file = File.join(APP_ROOT, 'config', 'interest_mapping.json')
      mapping = JSON.parse(File.read(file))
      client = ES.client
      client.indices.delete index: ['interests'] if client.indices.exists? index: 'interests'
      client.indices.create index: 'interests', body: mapping
      log :info, tn, 'done'
    rescue StandardError => e
      log :fatal, tn, e.message
      log :fatal, tn, e.backtrace
      log :fatal, tn, JSON.parse(e.response[:body])
    end
  end
end
