# frozen_string_literal: true

namespace :other do
  task :test do |tn|
    FR::Location.all.order_by(date: :asc).each do |location|
      ## iterate over all interests
      FR::Interest.all.each do |interest|
        next unless interest.include?(location.coordinates.lat, location.coordinates.lon)

        pp location.attributes
      end
    end
  end
end
