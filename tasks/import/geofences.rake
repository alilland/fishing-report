# frozen_string_literal: true

namespace :import do
  ##
  task :geofences do |tn|
    log :debug, tn, 'start'

    Dir.foreach("#{APP_ROOT}/tmp/geofences") do |filename|
      next if ['.', '..'].include? filename
      next unless filename.ends_with?('.txt')

      place = filename.gsub('.txt', '')
      interest = FR::Interest.where(name: place).first
      interest = FR::Interest.new if interest.nil?

      interest.name = place
      interest.geofence = []

      log :debug, tn, "importing #{filename}"
      File.foreach("#{APP_ROOT}/tmp/geofences/#{filename}", encoding: 'bom|utf-8') do |line|
        csv_data = CSV.parse(line, col_sep: ',', headers: false)
        row = csv_data[0]
        lat = row[0]
        lon = row[1]

        interest.geofence << [lat, lon]
      end

      interest.save!
    rescue StandardError => e
      log :warn, tn, e.message
      log :warn, tn, e.backtrace
    end

    log :info, tn, 'done'
  rescue StandardError => e
    log :fatal, tn, e.message
    log :fatal, tn, e.backtrace
  end
end
