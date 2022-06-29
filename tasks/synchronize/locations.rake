# frozen_string_literal: true

##
namespace :synchronize do
  ##
  task :locations do |tn|
    log :debug, tn, 'start'

    client = ES.client

    FR::Location.all.order_by(updated_at: :desc).each do |location|
      client.index index: 'locations', id: location.id.to_s, body: {
        created_at: location.created_at.iso8601(0),
        updated_at: location.updated_at.iso8601(0),
        state: location.state,
        date: location.date.iso8601(0),
        county: location.county,
        name: location.name,
        specie: location.specie,
        coordinates: {
          lat: location.coordinates.lat,
          lon: location.coordinates.lon
        },
        unit_id: location.unit_id
      }
      log :debug, tn, "synced #{location.name} #{location.unit_id}"
    rescue StandardError => e
      log :warn, tn, e.message
      log :warn, tn, e.backtrace
      log :warn, tn, JSON.parse(e.response[:body])
    end

    log :info, tn, 'done'
  rescue StandardError => e
    log :fatal, tn, e.message
    log :fatal, tn, e.backtrace
  end
end
