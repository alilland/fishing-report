# frozen_string_literal: true

namespace :notifications do
  task :interests do |tn|
    log :debug, tn, 'start'
    client = TextMessage.client

    day_start = Time.now.beginning_of_day
    day_end = Time.now.end_of_day
    payload = { created_at: { '$gte' => day_start, '$lte' => day_end } }
    FR::Location.where(payload).order_by(date: :asc).each do |location|
      ## iterate over all interests
      FR::Interest.all.each do |interest|
        ## only interests that fall within our geofences
        next unless interest.include?(location.coordinates.lat, location.coordinates.lon)

        message = "#{location.specie.titleize} Stocking Event #{location.date.strftime('%m/%d/%Y')}, #{location.name}/#{location.county} - http://maps.apple.com/?daddr=#{location.coordinates.lat},#{location.coordinates.lon}"
        client.messages.create(
          from: ENV['TWILIO_PHONE'],
          to: ENV['RECIPIENT_PHONE'],
          body: message
        )
        log :debug, tn, message
      end
    end
    log :info, tn, 'done'
  end
end
