# frozen_string_literal: true

##
namespace :synchronize do
  ##
  task :interests do |tn|
    log :debug, tn, 'start'

    client = ES.client

    FR::Interest.all.order_by(updated_at: :desc).each do |interest|
      client.index index: 'interests', id: interest.id.to_s, body: {
        created_at: interest.created_at.iso8601(0),
        updated_at: interest.updated_at.iso8601(0),
        name: interest.name,
        geofence: {
          type: 'Polygon',
          coordinates: interest.geofence.map { |f| { lat: f[0], lon: f[1] } }
        }
      }
      log :debug, tn, "synced #{interest.name}"
    rescue StandardError => e
      log :warn, tn, JSON.parse(e.response[:body])
    end

    log :info, tn, 'done'
  rescue StandardError => e
    log :fatal, tn, e.message
    log :fatal, tn, e.backtrace
  end
end
